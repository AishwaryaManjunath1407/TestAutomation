Feature: An example

  Scenario Outline: Validating the scenarios of posts of a user
    Given Testing the posts functionality for userPostsOption "<userPostsOption>" and userId "<userId>" and postId "<postId>"
    When Headers "<Accept>" and "<Content-Type>" and "<Authorization>"
    Then the "<RequestMethod>" call is made with "<RequestBody>"
    And the http status code matches "<httpStatus>"
    And the response "<Expectedfilename>" is returned from Post Endpoints "/src/test/resources/ExpectedJsonFile/Post"

    Examples:
      | Testcase no                                                    | Expectedfilename          | Accept           | Content-Type     | Authorization                                                     | httpStatus | RequestMethod | RequestBody                                            | userId  | postId | userPostsOption |
      | Success Response to get list of posts for a user               |                           | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 200        | get           |                                                        | 1304985 |        | option1         |
      | Success Response to create a post for a user given in endpoint | PostOp.json               | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 201        | post          | /src/test/resources/RequestBody/CreatePostOption1.json | 1304985 |        | option1         |
      | Success Response to create a post for a user given in Req body | PostOp.json               | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 201        | post          | /src/test/resources/RequestBody/CreatePostOption2.json |         |        | option2         |
      | Success Response to get list of posts for all users            |                           | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 200        | get           |                                                        |         |        | option2         |
      | Failure Response for not providing token                       | AuthenticationFailed.json | application/json | application/json |                                                                   | 401        | post          | /src/test/resources/RequestBody/CreatePostOption2.json |         |        | option2         |
      | Failure Response to create a post for a user without Req body  | FailurePost.json          | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 422        | post          | /src/test/resources/RequestBody/Empty.json             |         |        | option2         |
      | Failure Response to delete a post based on postId              | NonExistingPost.json      | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 404        | delete        |                                                        |         | 123    | option2         |
      | Success Response to delete a post based on postId              |                           | application/json | application/json | a4d01bb224163ae07a44168015b95a405782feab319515d9745c20415c1623c9  | 204        | delete        |                                                        |         | 17230  | option2         |