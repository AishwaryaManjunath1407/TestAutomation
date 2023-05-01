package com.automation;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.restassured.RestAssured;
import io.restassured.http.Header;
import io.restassured.http.Headers;
import io.restassured.response.Response;
import io.restassured.response.ResponseBody;
import io.restassured.specification.RequestSpecification;
import org.json.JSONObject;
import org.skyscreamer.jsonassert.JSONAssert;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class StepDefinitions {

  public RequestSpecification httpRequest;

  public Response actualResponse;

  public ResponseBody body;

  private String responseBody;

  public int actualStatusCode;

  @Given("Testing the users functionality with userId \"(.*)\" and version \"(.*)\"$")
  public void test_endpoint(String userId, String version) {
    String URL = "https://gorest.co.in/";
    RestAssured.baseURI = URL + "public/" + version + "/users/"+userId;
    httpRequest = RestAssured.given();
  }

  @When("User get \"(.*)\" and \"(.*)\" and \"(.*)\"$")
  public void user_get_headers(String accept, String contentType, String authorization) {
    List<Header> headersList = new ArrayList<Header>();
    Header header1 = null;
    Header header2 = null;
    Header header3 = null;
    Headers headers = null;

    if (accept != null && !accept.isEmpty()) {
      header1 = new Header("Accept", accept);
      headersList.add(header1);
    }
    if (contentType != null && !contentType.isEmpty()) {
      header2 = new Header("Content-Type", contentType);
      headersList.add(header2);
    }
    if (authorization != null && !authorization.isEmpty()) {
      header3 = new Header("Authorization", "Bearer " + authorization);
      headersList.add(header3);
    }
    headers = new Headers(headersList);
    httpRequest.headers(headers);
  }


  @Then("the \"(.*)\" call should be made with \"(.*)\"$")
  public void the_required_call_should_be_made(String requestMethod, String fileBodyPath) throws IOException {
    switch (requestMethod) {
      case "post":
        JSONObject expectedRequest = getJsonRequest(fileBodyPath);
        if (fileBodyPath.contains("SuccessPost.json")) {
          expectedRequest.put("email", "test" + UUID.randomUUID() + "@gmail.com");
        }
        httpRequest.body(expectedRequest.toString());
        actualResponse = httpRequest.relaxedHTTPSValidation().when().post();
        break;
      case "get":
        actualResponse = httpRequest.relaxedHTTPSValidation().when().get();
        break;
      case "delete":
        actualResponse = httpRequest.relaxedHTTPSValidation().when().delete();
        break;
    }

    body = actualResponse.getBody();
//        scenario.log(body.prettyPrint());
    responseBody = body.asString();
  }


  @And("the http status code should match \"(.*)\"$")
  public void the_http_status_code_should_match(int httpStatus) {
    actualStatusCode = actualResponse.getStatusCode();
    assertEquals(httpStatus, actualStatusCode);
  }

  @And("the response \"(.*)\" is returned from User Endpoints \"(.*)\"$")
  public void the_responses_is_returned(String ExpectedJsonFileName, String ExpectedJsonFilePath) throws IOException {
    if (!ExpectedJsonFileName.isEmpty()) {
      String ExpectedJsonFileFullPath = System.getProperty("user.dir") + ExpectedJsonFilePath;
      String expectedJson = new String(Files.readAllBytes(Paths.get(ExpectedJsonFileFullPath + File.separator + ExpectedJsonFileName)));
      if (201 == actualStatusCode) {
        JSONObject response = new JSONObject(responseBody);
        response.remove("id");
        response.remove("email");
        JSONAssert.assertEquals(expectedJson, response.toString(), true);
      } else {
        JSONAssert.assertEquals(expectedJson, responseBody, true);
      }
    }
  }

  public JSONObject getJsonRequest(String jsonBodyPath) throws IOException {
    String ExpectedJsonFileFullPath = new String(Files.readAllBytes(Paths.get(System.getProperty("user.dir") + jsonBodyPath)));
    return new JSONObject(ExpectedJsonFileFullPath);
  }

}