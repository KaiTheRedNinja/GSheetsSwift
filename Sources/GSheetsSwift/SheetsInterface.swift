// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation
import GSheetsSwiftAPI
import GSheetsSwiftTypes

public class SheetsInterface: ObservableObject {
    @Published private(set) public var spreadsheet: Spreadsheet?
    @Published private(set) public var targetSheet: Sheet?

    public init() {}

    /// The oauth access token. Wrapper for ``APISecretManager.accessToken``.
    static var accessToken: String {
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

    enum SheetsInterfaceError: Error {
        case noSheetToRefresh
    }

    public func reloadSpreadsheet() async throws {
        guard let id = spreadsheet?.spreadsheetId else { throw SheetsInterfaceError.noSheetToRefresh }
        try await loadSpreadsheet(id: id)
    }

    /// Gets the names for sheets
    public func namesOfSheets() -> [String] {
        guard let spreadsheet else { return [] }
        return spreadsheet.sheets.map({ $0.properties.title })
    }

    /// Focuses a sheet within the spreadsheet with a given name
    public func focusSheet(name: String) {
        self.targetSheet = spreadsheet?.sheets.first(where: { $0.properties.title == name })
    }

    /// Returns the contents of the specified row number, starting from startCol and ending before endCol.
    /// May return less than the specified number of rows.
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
    /// May return less than the specified number of rows.
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

    /// Writes the contents at the specified cell
    public func writeCell(
        contents: String,
        row: Int,
        col: Int
    ) {
        guard let spreadsheet, let targetSheet else { return }

        let sheetId = targetSheet.properties.sheetId

        let updateCellsRequest = UpdateCellsRequest(
            rows: [.init(values: [.init(userEnteredValue: .init(stringValue: contents))])],
            fields: "*",
            start: .init(sheetId: sheetId, rowIndex: row, columnIndex: col)
        )

        GSheetsSwiftAPI.ATSpreadsheets.update(
            params: .init(spreadsheetId: spreadsheet.spreadsheetId),
            query: .init(),
            data: .init(
                requests: [
                    .init(updateCells: updateCellsRequest)
                ],
                includeSpreadsheetInResponse: false,
                responseRanges: [],
                responseIncludeGridData: false)
        ) { result in
            switch result {
            case .success(_):
                print("Success!")
            case .failure(_):
                print("Failure :(")
            }
        }
    }
}

public struct CellContent: Hashable {
    public var row: Int
    public var col: Int

    public var content: String?

    public init(row: Int, col: Int, content: String? = nil) {
        self.row = row
        self.col = col
        self.content = content
    }
}

public extension Array {
    func at(_ index: Index) -> Element? {
        if index >= 0 && index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
}
