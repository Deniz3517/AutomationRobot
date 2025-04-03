*** Settings ***
Library    RequestsLibrary

Resource    ../../keywords/ui-keywords/globalVariables.robot
Resource    ../../keywords/api-keywords/get-request-response.robot

*** Variables ***

*** Test Cases ***
[Automation-Robot] Automation Exercise Products List - Health check
    [Tags]    API    SMOKE    Test-0001
    GET API Request    ${AUTOMATIONEXERCISE_LINK}/api/productsList    200

[Automation-Robot] Automation Exercise Brands List - Health check
    [Tags]    API    SMOKE    Test-0002
    GET API Request    ${AUTOMATIONEXERCISE_LINK}/api/brandsList    200

