// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import GSheetsSwiftAPI
import GSheetsSwiftTypes

public typealias GSheetResponseCallback = (Result<GSheetsSwiftAPI.ATSpreadsheets.UpdateResponseData, Error>) -> Void

/// A simplified interface to a Google Sheet, which implements commonly used APIs in `GSheetsSwiftAPI`
///
/// This interface is the recommended way to interface with Google Sheets via GSheetsSwift, unless you need
/// more precise control over exactly how commands are called.
///
/// Note that this sheets interface currently assumes that your data is *continuous*. That means that if your data
/// has empty rows between populated rows or empty columns between populated columns, it may behave weirdly.
public class SheetsInterface: ObservableObject {
    /// The current spreadsheet loaded into the interface
    @Published private(set) public var spreadsheet: Spreadsheet? {
        didSet {
            changeDelegate?.spreadsheetDidChange(interface: self, spreadsheet: spreadsheet)
        }
    }
    /// The current sheet within the spreadsheet that the interface is performing read/write operations on
    @Published private(set) public var targetSheet: Sheet? {
        didSet {
            changeDelegate?.targetSheetDidChange(interface: self, targetSheet: targetSheet)
        }
    }
    /// The change delegate, which is informed when any changes are made to the internal representation of the google
    /// sheet, by this interface.
    ///
    /// Note that this does not detect changes made by *other* editors of the google sheet, only *this* `SheetsInterface`
    public weak var changeDelegate: SheetsInterfaceChangeDelegate?

    /// A list of of update requests, which are batched together and sent every ``updateRequestPeriod`` seconds
    public private(set) var updateRequests: [([UpdateRequest], GSheetResponseCallback?)] = []

    /// The time interval where update requests will be batched together. For example, if set to 3 (default), update commands
    /// will be sent at most once every three seconds, with all the edits batched together as one write operation
    public var updateRequestPeriod: TimeInterval = 3.0

    /// Creates an empty `SheetsInterface`
    public init() {}

    /// The oauth access token. Wrapper for `APICaller.APISecretManager.accessToken`.
    ///
    /// This access token is shared throughout the entire app
    public static var accessToken: String {
        get { APISecretManager.accessToken }
        set { APISecretManager.accessToken = newValue }
    }

    /// Loads the spreadsheet for a given id
    public func loadSpreadsheet(id: String) async throws {
        try await withCheckedThrowingContinuation { cont in
            GSheetsSwiftAPI.ATSpreadsheets.get(
                params: .init(spreadsheetId: id),
                query: .init(includeGridData: true),
                data: .init()
            ) { result in
                switch result {
                case .success(let sheet):
                    DispatchQueue.main.async {
                        self.spreadsheet = sheet
                    }
                    cont.resume(returning: Void())
                case .failure(let error):
                    print("Error :(")
                    cont.resume(throwing: error)
                }
            }
        }
    }

    /// Errors that the sheets interface can encounter
    enum SheetsInterfaceError: Error {
        case noSheetToRefresh
    }

    /// Reloads the spreadsheet, similar to re-running `loadSpreadsheet`
    public func reloadSpreadsheet() async throws {
        guard let id = spreadsheet?.spreadsheetId else { throw SheetsInterfaceError.noSheetToRefresh }
        try await loadSpreadsheet(id: id)
    }

    /// Deletes all the sheet data in this `SheetsInterface` instance
    public func resetSpreadsheet() {
        spreadsheet = nil
        targetSheet = nil
        objectWillChange.send()
    }

    /// Gets the names for sheets
    /// - Returns: The names of the sheets
    public func namesOfSheets() -> [String] {
        guard let spreadsheet else { return [] }
        return spreadsheet.sheets.map({ $0.properties.title })
    }

    /// Focuses a sheet within the spreadsheet with a given name. This sets the ``targetSheet`` property.
    /// - Parameter name: The name of the sheet to focus
    public func focusSheet(name: String) {
        self.targetSheet = spreadsheet?.sheets.first(where: { $0.properties.title == name })
    }

    /// Returns the contents of the specified row number, starting from startCol and ending before endCol.
    /// May return less than the specified number of rows.
    /// - Parameters:
    ///   - row: The row to read
    ///   - startCol: The column to start reading from
    ///   - endCol: The column to end reading
    /// - Returns: An array, from left to right, of the content within the cells
    public func readRow(
        _ row: Int,
        startCol: Int? = nil,
        endCol: Int? = nil
    ) -> [CellContent] {
        // Assumption: All the data will be in the first item in targetSheet.data
        guard let targetSheet, let grid = targetSheet.data.first else {
            print("No target sheet or grid")
            return []
        }

        let rowOffset = grid.startRow ?? 0
        let colOffset = grid.startColumn ?? 0

        guard let items = grid.rowData.at(row-rowOffset)?.values else {
            print("No such row: \(row)")
            return []
        }

        let cellContents = items.enumerated().map { (index, cellData) -> CellContent in
                .init(row: row, col: colOffset + index, content: cellData.formattedValue)
        }

        return cellContents.filter { cellContent in
            if let startCol, !(startCol <= cellContent.col) {
                return false
            }
            if let endCol, !(cellContent.col < endCol) {
                return false
            }
            return true
        }
    }

    /// Returns the contents of the specified column number, starting from startRow and ending before endRow.
    /// May return less than the specified number of columns.
    /// - Parameters:
    ///   - col: The column to read
    ///   - startRow: The row to start reading from
    ///   - endRow: The row to end reading
    /// - Returns: An array, from top to bottom, of the content within the cells
    public func readColumn(
        _ col: Int,
        startRow: Int? = nil,
        endRow: Int? = nil
    ) -> [CellContent] {
        // Assumption: All the data will be in the first item in targetSheet.data
        guard let targetSheet, let grid = targetSheet.data.first else { return [] }

        let rowOffset = grid.startRow ?? 0
        let colOffset = grid.startColumn ?? 0

        let items = grid.rowData.map({ $0.values.at(col-colOffset) })

        let cellContents = items.enumerated().map { (index, cellData) -> CellContent in
                .init(row: rowOffset + index, col: col, content: cellData?.formattedValue)
        }

        return cellContents.filter { cellContent in
            if let startRow, !(startRow <= cellContent.row) {
                return false
            }
            if let endRow, !(cellContent.row < endRow) {
                return false
            }
            return true
        }
    }
    
    /// Reads the contents at a given cell
    /// - Parameters:
    ///   - row: The row of the cell
    ///   - col: The column of the cell
    /// - Returns: The content at the cell, if it exists
    public func readCell(
        row: Int,
        col: Int
    ) -> CellContent? {
        // Assumption: All the data will be in the first item in targetSheet.data
        guard let targetSheet, let grid = targetSheet.data.first else { return nil }
        // check that its within range
        let row = readRow(row)
        return row.at(col-(grid.startColumn ?? 0))
    }

    /// Reads all contents from a sheet
    /// - Returns: A grid containing the content of the cell
    public func readAll() -> [[CellContent]] {
        guard let targetSheet, let grid = targetSheet.data.first else { return [] }

        let rowOffset = grid.startRow ?? 0
        let colOffset = grid.startColumn ?? 0

        return grid.rowData.enumerated().map { (row, rowData) in
            rowData.values.enumerated().map { (col, cellData) in
                CellContent(row: row+rowOffset, col: col+colOffset, content: cellData.formattedValue)
            }
        }
    }

    /// Writes the contents at the specified cell
    /// - Parameters:
    ///   - contents: The string content to write to the given cell
    ///   - row: The row of the cell to write to
    ///   - col: The column of the cell to write to
    ///   - updateInternalRepresentation: Whether the write should update ``spreadsheet``. Note that this
    ///   may increase the time taken for requests to complete.
    ///   - batch: Whether or not this call will be batched together with other calls. This may result in an up to ``updateRequestPeriod``
    ///   second delay in request timing. Defaults to false.
    ///   - completion: A closure to call when the operation succeeds
    public func writeCell(
        contents: String,
        row: Int,
        col: Int,
        updateInternalRepresentation: Bool = false,
        batch: Bool = false,
        completion: (GSheetResponseCallback)? = nil
    ) {
        guard let targetSheet else { return }

        let sheetId = targetSheet.properties.sheetId

        let updateCellsRequest = UpdateCellsRequest(
            rows: [.init(values: [.init(userEnteredValue: .init(stringValue: contents))])],
            fields: "*",
            start: .init(sheetId: sheetId, rowIndex: row, columnIndex: col)
        )

        update(
            requests: [.init(updateCells: updateCellsRequest)],
            updateInternalRepresentation: updateInternalRepresentation,
            batch: batch,
            completion: completion
        )
    }

    /// Appends a row below the last row with data, creating it if nescessary
    /// - Parameters:
    ///   - rows: An array of rows, top to bottom, to append to the bottom of the data
    ///   - updateInternalRepresentation: Whether the write should update ``spreadsheet``. Note that this
    ///   may increase the time taken for requests to complete.
    ///   - batch: Whether or not this call will be batched together with other calls. This may result in an up to ``updateRequestPeriod``
    ///   second delay in request timing. Defaults to false.
    ///   - completion: A closure to call when the operation succeeds
    public func appendRow(
        _ rows: [RowData],
        updateInternalRepresentation: Bool = false,
        batch: Bool = false,
        completion: (GSheetResponseCallback)? = nil
    ) {
        guard let targetSheet else { return }

        let sheetId = targetSheet.properties.sheetId

        let appendCellsRequest = AppendCellsRequest(
            sheetId: sheetId,
            rows: rows,
            fields: "*"
        )

        update(
            requests: [.init(appendCells: appendCellsRequest)],
            updateInternalRepresentation: updateInternalRepresentation,
            batch: batch,
            completion: completion
        )
    }

    /// Inserts empty rows or columns in a range, pushing data to the right or bottom if needed.
    /// - Parameters:
    ///   - range: The range, either for columns or rows, to insert empty data into
    ///   - direction: The direction, either columns or rows, to insert empty data into
    ///   - updateInternalRepresentation: Whether the write should update ``spreadsheet``. Note that this
    ///   may increase the time taken for requests to complete.
    ///   - batch: Whether or not this call will be batched together with other calls. This may result in an up to ``updateRequestPeriod``
    ///   second delay in request timing. Defaults to false.
    ///   - completion: A closure to call when the operation succeeds
    public func insertRange(
        _ range: Range<Int>,
        direction: DimensionEnum,
        updateInternalRepresentation: Bool = false,
        batch: Bool = false,
        completion: (GSheetResponseCallback)? = nil
    ) {
        guard let targetSheet else { return }

        let sheetId = targetSheet.properties.sheetId

        let insertDimensionsRequest = InsertDimensionRequest(
            range: .init(sheetId: sheetId, dimension: direction, startIndex: range.lowerBound, endIndex: range.upperBound),
            inheritFromBefore: true
        )

        update(
            requests: [.init(insertDimension: insertDimensionsRequest)],
            updateInternalRepresentation: updateInternalRepresentation,
            batch: batch,
            completion: completion
        )
    }

    /// Batch-sends update requests. Usually used to send multiple requests at the same time, instead of
    /// individually.
    /// - Parameters:
    ///   - requests: The requests to send
    ///   - updateInternalRepresentation: Whether the write should update ``spreadsheet``. Note that this
    ///   may increase the time taken for requests to complete.
    ///   - batch: Whether or not this call will be batched together with other calls. This may result in an up to ``updateRequestPeriod``
    ///   second delay in request timing. Defaults to false.
    ///   - completion: A closure to call when the operation succeeds
    public func update(
        requests: [UpdateRequest],
        updateInternalRepresentation: Bool = false,
        batch: Bool = false,
        completion: (GSheetResponseCallback)? = nil
    ) {
        guard let spreadsheetId = spreadsheet?.spreadsheetId else { return }

        if batch {
            let isFirst = updateRequests.isEmpty
            updateRequests.append((requests, completion))

            guard isFirst else { return }

            DispatchQueue.main.asyncAfter(deadline: .now() + updateRequestPeriod) { [weak self] in
                guard let self else { return }

                let requests = updateRequests.flatMap { $0.0 }
                let callbacks = updateRequests.compactMap { $0.1 }

                // Reset the update requests
                updateRequests = []

                GSheetsSwiftAPI.ATSpreadsheets.update(
                    params: .init(spreadsheetId: spreadsheetId),
                    query: .init(),
                    data: .init(
                        requests: requests,
                        includeSpreadsheetInResponse: updateInternalRepresentation,
                        responseRanges: [],
                        responseIncludeGridData: false)
                ) { [weak self] result in
                    guard let self else { return }

                    switch result {
                    case .success(let response):
                        if let updatedSpreadsheet = response.updatedSpreadsheet {
                            self.spreadsheet = updatedSpreadsheet
                        }
                    case .failure(_):
                        print("Failure :(")
                    }

                    // Call all the completion handlers
                    callbacks.forEach { $0(result) }
                }
            }
        } else {
            GSheetsSwiftAPI.ATSpreadsheets.update(
                params: .init(spreadsheetId: spreadsheetId),
                query: .init(),
                data: .init(
                    requests: requests,
                    includeSpreadsheetInResponse: updateInternalRepresentation,
                    responseRanges: [],
                    responseIncludeGridData: false)
            ) { result in
                switch result {
                case .success(let response):
                    if let updatedSpreadsheet = response.updatedSpreadsheet {
                        self.spreadsheet = updatedSpreadsheet
                    }
                case .failure(_):
                    print("Failure :(")
                }
                completion?(result)
            }
        }
    }
}

/// A protocol that defines interfaces for being informed of a ``SheetsInterface``'s changes
public protocol SheetsInterfaceChangeDelegate: AnyObject {
    /// Executed when the spreadsheet is set
    func spreadsheetDidChange(interface: SheetsInterface, spreadsheet: Spreadsheet?)
    /// Executed when the target sheet is set
    func targetSheetDidChange(interface: SheetsInterface, targetSheet: Sheet?)
}

/// The content of a cell
public struct CellContent: Hashable {
    /// The row of a cell
    public var row: Int
    /// The column of a cell
    public var col: Int

    /// The string content of a cell
    public var content: String?

    /// Creates a cell content with a row, column, and optionally content
    public init(row: Int, col: Int, content: String? = nil) {
        self.row = row
        self.col = col
        self.content = content
    }
}

extension Array {
    func at(_ index: Index) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
}
