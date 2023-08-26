# GSheetsSwift

A library for interacting with the Google Sheets API

## Usage instructions
1. Add this library to your project using SPM and this github link
2. Import `GSheetsSwift` in your project
3. Set the `SheetsInterface.accessToken` static property to your oauth api key
4. Create a `SheetsInterface` instance
5. Using that instance, load your spreadsheet using the `loadSpreadsheet` function on its id. The ID of a google sheet can be found in its url (eg. `https://docs.google.com/spreadsheets/d/[ID IS HERE]/edit`)
6. Use `namesOfSheets` to get the pages in the sheet
7. Use `focusSheet`, passing the name of one of the sheets, to focus it. If this isn't called or is called with a nonexistent sheet's name, any read/write operations will fail.
8. Use `readRow`, `readColumn`, `readCell`, or `writeCell` to perform operations on it

## Advanced usage instructions
Import `GSheetsSwiftAPI` to have full access to the underlying REST APIs. Set `APISecretManager.accessToken` to your oauth api key, and use ATSpreadsheets to access the REST methods directly.

Note that `GSheetsSwift`'s `SheetsInterface` uses different higher-level data representations as compared to `GSheetsSwiftAPI`, which utilises data types that match more similarly to what is provided by the google sheets REST API.
