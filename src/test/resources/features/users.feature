Feature: An example

   Scenario Outline: Validating the scenarios of list users
     Given Testing the users functionality with userId "<userId>" and version "<version>"
     When User get "<Accept>" and "<Content-Type>" and "<Authorization>"
     Then the "<RequestMethod>" call should be made with "<RequestBody>"
     And the http status code should match "<httpStatus>"
     And the response "<Expectedfilename>" is returned from User Endpoints "/src/test/resources/ExpectedJsonFile/User"

     Examples:
       | Testcase no                                         | Expectedfilename          | Accept           | Content-Type     | Authorization                                                     | httpStatus | version | RequestMethod | RequestBody                                        | userId  |
       | Success Response to get list of users for version 1 |                           | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 200        | v1      | get           |                                                    |         |
       | Success Response to get list of users for version 2 |                           | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 200        | v2      | get           |                                                    |         |
       | Success Response to create the user                 | CreateUser.json           | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 201        | v2      | post          | /src/test/resources/RequestBody/SuccessPost.json   |         |
       | User Email blank while creating the user            | EmailBlank.json           | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 422        | v2      | post          | /src/test/resources/RequestBody/FailurePost.json   |         |
       | Existing Email while creating the user              | DuplicateEmail.json       | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 422        | v2      | post          | /src/test/resources/RequestBody/DuplicatePost.json |         |
       | Delete User with non-existing id                    | NonExistingUser.json      | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 404        | v2      | delete        |                                                    | 123     |
       | Failure Response for not providing token            | AuthenticationFailed.json | application/json | application/json |                                                                   | 401        | v2      | post          | /src/test/resources/RequestBody/SuccessPost.json   |         |
       | Delete User with valid Id                           |                           | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 204        | v2      | delete        |                                                    | 1333742 |