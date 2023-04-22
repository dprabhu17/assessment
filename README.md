# Assessment
An assessment to evaluate technical ability, we would like to develop a native iOS application which consume simple web servies (RESTful) and display the results appropriately in mobile app.

## Requirement:
- Fetch list of records from API and display the results in a list.
- Add a button on top right to sort the results based on name property.
- On tap of an individual list item, consume API to retrieve more details about the item and navigate to a new screen which displays the result appropriately.

Link to test the app online: https://appetize.io/app/uelhxp2u7nf5avfciggo67dtlu

## Tools & Technologies used:
- IDE      : XCode 14.2
- Language : Swift 5.7
- Tool     : SwiftLint 0.51.0

### Notes:
* Design Patterns:
    * `Model View Presenter` is used as an architecture design pattern to implement this app.
    * `Factory design pattern` is used to construct view controllers without exposing the creation logics.
    * `Coordinator design pattern` is used to manage navigation flows across our app and helps to remove loosly coupled code from view controller.
    * `Adapter design pattern` is used to easily use and change HTTP clients if it's required in future.
    * `Decorator design pattern` is used to manage API endpoints, Image and Color assets for our app.
    * `Repository design pattern` is used to maintain single entry point to work with API calls and also helps to reduce code duplication.

* Dependencies:
    * `SwiftLint` integrated via Swift Package Manager to enforce swift style and conventions.
    * `RxSwift` is used over URLSession to utilize for RESTful web services.

* Features included:
    * Clean code based on my experience with MVP architecture.
    * Used size classes to improve user experience in iPhone and iPad.
    * Used Operation Queues an updated operation’s priority based on visible cells.
    * Minimum iOS requirement is 14.0
    * Added unit test cases and improved code coverage upto 100 percentage for Presenters and View controllers also improved entire project's code coverage upto 94+ percentage.
