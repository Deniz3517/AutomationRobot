*** Settings ***
Library    RequestsLibrary
Library    Collections

Resource    ../../keywords/ui-keywords/globalVariables.robot
Resource    ../../keywords/api-keywords/get-request-response.robot

*** Variables ***
${API_URL}    ${AUTOMATIONEXERCISE_LINK}api

*** Test Cases ***

# ─── PRODUCTS ────────────────────────────────────────────────────────────────

[Automation-Robot] Products List - Health Check
    [Tags]    API    SMOKE    Test-0001
    GET API Request    ${API_URL}/productsList    200

[Automation-Robot] Products List - Response Body Contains Products Key
    [Tags]    API    REGRESSION    Test-0002
    ${response}=    GET API Request And Validate Response Body
    ...    ${API_URL}/productsList    200    products
    ${items}=    Validate Response Contains List    ${response}    products
    Should Not Be Empty    ${items}

[Automation-Robot] Products List - Response Code In Body Is 200
    [Tags]    API    REGRESSION    Test-0003
    GET API Request And Validate Response Code In Body    ${API_URL}/productsList    200

[Automation-Robot] Products List - POST Method Not Supported
    [Tags]    API    NEGATIVE    Test-0004
    ${response}=    POST API Request And Validate Response Code In Body
    ...    ${API_URL}/productsList    405
    Validate Response Message    ${response}    This request method is not supported.

# ─── BRANDS ──────────────────────────────────────────────────────────────────

[Automation-Robot] Brands List - Health Check
    [Tags]    API    SMOKE    Test-0005
    GET API Request    ${API_URL}/brandsList    200

[Automation-Robot] Brands List - Response Body Contains Brands Key
    [Tags]    API    REGRESSION    Test-0006
    ${response}=    GET API Request And Validate Response Body
    ...    ${API_URL}/brandsList    200    brands
    ${items}=    Validate Response Contains List    ${response}    brands
    Should Not Be Empty    ${items}

[Automation-Robot] Brands List - Response Code In Body Is 200
    [Tags]    API    REGRESSION    Test-0007
    GET API Request And Validate Response Code In Body    ${API_URL}/brandsList    200

[Automation-Robot] Brands List - PUT Method Not Supported
    [Tags]    API    NEGATIVE    Test-0008
    ${response}=    POST API Request And Validate Response Code In Body
    ...    ${API_URL}/brandsList    405
    Validate Response Message    ${response}    This request method is not supported.

# ─── SEARCH PRODUCT ──────────────────────────────────────────────────────────

[Automation-Robot] Search Product - Valid Search Returns Results
    [Tags]    API    SMOKE    REGRESSION    Test-0009
    ${data}=    Create Dictionary    search_product=top
    ${response}=    POST API Request And Validate Response Code In Body
    ...    ${API_URL}/searchProduct    200    ${data}
    ${items}=    Validate Response Contains List    ${response}    products
    Should Not Be Empty    ${items}

[Automation-Robot] Search Product - Missing Parameter Returns 400
    [Tags]    API    NEGATIVE    Test-0010
    ${response}=    POST API Request And Validate Response Code In Body
    ...    ${API_URL}/searchProduct    400
    Validate Response Message    ${response}
    ...    Bad request, search_product parameter is missing in POST request.

[Automation-Robot] Search Product - GET Method Not Supported
    [Tags]    API    NEGATIVE    Test-0011
    GET API Request And Validate Response Code In Body    ${API_URL}/searchProduct    405

# ─── VERIFY LOGIN ────────────────────────────────────────────────────────────

[Automation-Robot] Verify Login - Invalid Credentials Returns 404
    [Tags]    API    NEGATIVE    Test-0012
    ${data}=    Create Dictionary    email=invalid@test.com    password=wrongpass
    ${response}=    POST API Request And Validate Response Code In Body
    ...    ${API_URL}/verifyLogin    404    ${data}
    Validate Response Message    ${response}    User not found!

[Automation-Robot] Verify Login - Missing Email Parameter Returns 400
    [Tags]    API    NEGATIVE    Test-0013
    ${data}=    Create Dictionary    password=somepass
    ${response}=    POST API Request And Validate Response Code In Body
    ...    ${API_URL}/verifyLogin    400    ${data}
    Validate Response Message    ${response}    Bad request, email or password parameter is missing in POST request.

[Automation-Robot] Verify Login - GET Method Not Supported
    [Tags]    API    NEGATIVE    Test-0014
    GET API Request And Validate Response Code In Body    ${API_URL}/verifyLogin    405
