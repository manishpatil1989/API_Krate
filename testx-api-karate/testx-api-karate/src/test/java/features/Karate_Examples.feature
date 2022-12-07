
Feature: Validate Sample API functionality
  API Name: PostCode-API

  Background:
    * def td_api = read(`../testData/${env}/td_postcode_api.json`)
    * def td_common = read('../testData/common/td_common.json')

  @smoke @name=nft-gatling
  Scenario Outline: "<APIName>" - "<ScenarioName>" Validation & Performance Testing using Gatling
    * def baseUrl = td_api.baseUrl
    * def endPoint = td_common.postCode
    * def requestBody = td_api.postcode_bulklookup_request_body
    * def expResponse = td_api.postcode_bulklookup_response_body
    Given url baseUrl
    And path endPoint
    And request requestBody
    When method POST
    And header karate-name =  '<APIName>'
    Then status 200
    When def actResponse = response
    Then match actResponse == expResponse

    Examples:
      | APIName      | ScenarioName         |
      | PostCode-API | Get PostCode Details |

  @smoke
  Scenario Outline: "<APIName>" - "<ScenarioName>" Validation & Schema Validation
    * def baseUrl = td_api.baseUrl
    * def postCodeVal = td_common.outCode
    * def endPoint = td_common.outCodes + postCodeVal
    * def expResponse = td_api.postcode_lookupcode_response_body
    * def expSchema = td_api.postcode_lookupdcode_schema

    Given url baseUrl
    And path endPoint
    When method GET
    Then status 200
    When def actResponse = response
    Then match actResponse == expResponse
    And actResponse.status == expResponse.status
    And match actResponse == expSchema

    Examples:
      | APIName      | ScenarioName            |
      | PostCode-API | LookUp PostCode Details |


  @smoke
  Scenario Outline: Validate "<APIName>" - "<ScenarioName>" Using Java and JavaScript Custom Methods & Common Scenario from Feature File

    * def baseUrl = td_api.baseUrl
    * def endPoint = td_common.postCode
    * def requestBody = td_api.postcode_bulkreserve_request_body
    * def expResponse = td_api.postcode_bulkreserve_response_body

    * def javaUtils = Java.type('utility.JavaUtils')
    * def getUserNo = new javaUtils().getRandomNumber(50);
    * print 'getUserNo ---', getUserNo
    * def jsUtils = call read('../utility/JSUtils.js') 10
    * print 'JS getUserNo ---', jsUtils

    * def config = { baseUrl: '#(baseUrl)', endPoint: '#(endPoint)', requestBody: '#(requestBody)' }
    * def actResponse = call read('classpath:common/Karate_Common.feature@bulkReserve') config
    Then match actResponse.response == expResponse
    And match actResponse.response.status == expResponse.status

    Examples:
      | APIName      | ScenarioName |
      | PostCode-API | Bulk Reserve |


  @smoke
  Scenario Outline: Using Form Fields & Common Scenario from Feature File

    * def baseUrl = td_common.sampleAPIUrl
    * def contextPath = td_common.contextPath
    * def endPoint = td_common.registerUser
    * def params = td_common.register_api_params

    * def config = { baseUrl: '#(baseUrl)', contextPath: '#(contextPath)', endPoint: '#(endPoint)', params: '#(params)' }
    * def actResponse = call read('classpath:common/Karate_Common.feature@registerUser') config
    * print "actResponse :: ", actResponse

    Examples:
      | APIName    | ScenarioName         |
      | Sample-API | Sample Register User |


  @smoke
  Scenario Outline: Using GraphQL
    * def graphql = read('../testData/common/td_graphql_api.graphql')
    * def graphQLUrl = td_common.graphQLUrl
    Given url graphQLUrl
    And request { query: '#(graphql)' }
    When method POST
    Then status 200

    Examples:
      | APIName     | ScenarioName             |
      | graphql-api | Fetch Jobs Using GraphQL |
