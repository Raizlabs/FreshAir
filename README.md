# Fresh Air
Fresh Air is an application update library. It is designed check a remote location for application updates and if updates are available, prompt the user to upgrade the application. When the new version of the application is started, a dialog can be presented that show case the new features available to the user.

## Update Checks
Fresh Air supports checking iTunes for a new version, and checking a remotely hosted `release_notes.json` file.

## UI


### Update Confirmation Dialog
### Release Note Browser


## Release Notes
Along with the manifest, a `release_notes.json` file is included that describe the version history of the application. Every release entry contains any number of user-facing features. Each of these user facing features are displayed to the user with a localized marketing image, a title, and a description. Release entries also have a condition filtering system so versions  not supported by the current device or iOS Version are not displayed to the user. There are [Examples](Schema/Examples/TestFeature.freshair/release_notes.json) of the manifest file and a [JSON Schema](Schema/release_notes_schema.json) file is included.

## Remote Bundles
The transport layer for fresh air is implemented as an NSBundle that can be populated via a remote URL. The Remote URL contains a `manifest.json` file which lists all of the files that are available, the file SHA, and a condition. The conditions can be built to restrict assets based on locale, device type, or resolution. This allows the application to only download the slice of assets that are applicable to the device. There are [Examples](Schema/Examples/TestEmbeddedManifest.freshair/manifest.json) of the manifest file and a [JSON Schema](Schema/manifest_schema.json) file is included.

## Asset Lookup
The features defined in the release note file are defined as simple keys. These keys are then used to lookup localized strings (<feature_key>.title, <feature_key>.description), and an image. Since this is just a normal NSBundle from the applications perspective, normal localization search rules apply. So images will be first looked for in `Resources/`, and then will fall back to the localization-specific `.lproj` directory. Even though FreshAir comes with default View Controllers for presentation, it is also possible to write your own view controllers and pass in the `.freshair` NSBundle instead of the default application bundle.

## Condition Evaluation
Conditions are defined in the json as an array of JSON objects with `key`, `value`, and `comparison` properties. These are then transformed to a predicate and evaluated against a supplied `NSDictionary` that is pre-populated with a set of pre-populated values. 

|Key          | Value                                                         |
|-------------|---------------------------------------------------------------|
|platform     | "iOS"                                                         |
|version      | NSBundle.mainBundle.infoDictionary[CFBundleShortVersionString]|
|systemVersion| UIDevice.currentDevice.systemVersion                          |
|displayScale | UIScreen.mainScreen.scale                                     |

All values are converted to strings and compared using `NSNumericSearch`.


# Breeze
Breeze is a command line program to automate some of the tedious tasks involed with creating and managing manifest files. It will:

1. Update the SHA in the manifest file to match the files calculated SHA.
2. Update the manifest file with the appropriate conditions for the files related to the features in `release_notes.json`
3. Validate that there are localized keys and images for all features listed in `release_notes.json`.

