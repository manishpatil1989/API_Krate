Feature: PostCode APIs Common Scenarios

  @bulkReserve
  Scenario: Reques Get User Details
    Given url baseUrl
    And path endPoint
    And request requestBody
    When method POST
    Then status 200


  @registerUser
  Scenario: Register User using Formfields
    Given url baseUrl + contextPath
    And form fields params
    And path endPoint
    When method POST
    Then status 200
