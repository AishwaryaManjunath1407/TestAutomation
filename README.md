# TestAutomation
  A project for Cucumber and Rest API tests.

**Instructions**

Clone the repo:

Git:

$ git clone git@github.com:AishwaryaManjunath1407/TestAutomation.git

Or download a ZIP of project manually here (https://s101.recruiting.eu.greenhouse.io/tests/10a8b610f9dda9020ce103878ce2c9b8?utm_medium=email&utm_source=TakeHomeTest)
and expand the contents someplace on your system.

**Prerequisites**

In order to run Cucumber tests, the following softwares needs to be installed to your system.

Intellij code editor
JAVA SDK
MAVEN

**TestSite**

TestSuite in the project covers below testcases on V1 & V2 endpoints for Users and Posts.

Users:

  TC1. Success Response to get list of users for version 1
  TC2. Success Response to get list of users for version 2
  TC3. Success Response to create the user 
  TC4. User Email blank while creating a user
  TC5. Existing Email while creating the user
  TC6. Delete User with non-existing id
  TC7. Failure Response for not providing token
  TC8. Delete User with valid Id 
  
Posts:

  TC9. Success Response to get list of posts for a user
  TC10. Success Response to create a post for a user given in endpoint
  TC11. Success Response to create a post for a user given in Req body
  TC12. Success Response to get list of posts for all users 
  TC13. Failure Response for not providing token for authentication
  TC14. Failure Response to create a post for a user without Req body
  TC15. Failure Response to delete a post based on postId
  TC16. Success Response to delete a post based on postId
  
  
  
  Note: Please provide valid User ID and Post ID in the test data while deleting a User/Post for testcase(TC8 & TC16) to successfully pass.
  
**To Run the TestSuite**

mvn clean install 
mvn test
or right-click on TestRunner class and click Run >'RunCucumberTest'



