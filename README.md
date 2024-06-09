# GSheetsSwift

A library for interacting with the Google Sheets API

## Usage instructions
1. Add this library to your project using SPM and this github link
2. Import `GSheetsSwift` in your project
3. Set the `SheetsInterface.accessToken` static property to your oauth api key
4. Create a `SheetsInterface` instance
5. Using that instance, load your spreadsheet using the `loadSpreadsheet` function on its id. 
The ID of a google sheet can be found in its url (eg. `https://docs.google.com/spreadsheets/d/[ID IS HERE]/edit`)
6. Use `namesOfSheets` to get the pages in the sheet
7. Use `focusSheet`, passing the name of one of the sheets, to focus it. If this isn't called or is called with a 
nonexistent sheet's name, any read/write operations will fail.

Check the documentation [here](https://kaitheredninja.github.io/GSheetsSwift/GSheetsSwift/documentation/gsheetsswift) 
for the available methods you can call to read or mutate the google sheet.

## Advanced usage instructions
Import `GSheetsSwiftAPI` to have full access to the underlying REST APIs. Set `APISecretManager.accessToken` to your 
oauth api key, and use ATSpreadsheets to access the REST methods directly. Refer to the API documentation
[here](https://kaitheredninja.github.io/GSheetsSwift/GSheetsSwiftAPI/documentation/gsheetsswiftapi)

Note that `GSheetsSwift`'s `SheetsInterface` uses different higher-level data representations as compared to 
`GSheetsSwiftAPI`, which utilises data types that match more similarly to what is provided by the google sheets REST API.

## Building
GSheetsSwift is a Swift Package, and can be opened in Xcode just like any other.

To build the documentation, run these commands in the terminal from the root `GSheetsSwift` directory. These enable
pretty printing json (so that git plays nice with it), and then builds the documentation for each target in parallel.
```shell
export DOCC_JSON_PRETTYPRINT="YES"

swift package --allow-writing-to-directory docs/GSheetsSwift \
    generate-documentation --target GSheetsSwift \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path GSheetsSwift/GSheetsSwift \
    --output-path docs/GSheetsSwift & \
swift package --allow-writing-to-directory docs/GSheetsSwiftAPI \
    generate-documentation --target GSheetsSwiftAPI \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path GSheetsSwift/GSheetsSwiftAPI \
    --output-path docs/GSheetsSwiftAPI & \
swift package --allow-writing-to-directory docs/GSheetsSwiftTypes \
    generate-documentation --target GSheetsSwiftTypes \
    --disable-indexing \
    --transform-for-static-hosting \
    --hosting-base-path GSheetsSwift/GSheetsSwiftTypes \
    --output-path docs/GSheetsSwiftTypes
```

To preview this documentation on a local web server, run the following commands (again from the project's root). These
move the docs folder to where it would be in a deployment setting, then runs a local python server. When the server exits,
it reverts the position of docs.
```shell
mv docs GSheetsSwift
python3 -m http.server
mv GSheetsSwift docs
```
Then open the documentation site for
- [GSheetsSwift](http://localhost:8000/GSheetsSwift/GSheetsSwift/documentation/gsheetsswift/)
- [GSheetsSwiftAPI](http://localhost:8000/GSheetsSwift/GSheetsSwiftAPI/documentation/gsheetsswiftapi/)
- [GSheetsSwiftTypes](http://localhost:8000/GSheetsSwift/GSheetsSwiftTypes/documentation/gsheetsswifttypes/)
