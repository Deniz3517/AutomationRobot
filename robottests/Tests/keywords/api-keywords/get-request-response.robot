*** Settings ***
Library    RequestsLibrary
Library    Collections

Documentation    API Requests and Responses

*** Keywords ***

GET API Request
    [Arguments]    ${URL}    ${response_status_code}
    ${response}=    GET    ${URL}
    Status Should Be    ${response_status_code}    ${response}

POST API Request
    [Arguments]    ${URL}    ${response_status_code}    ${data}=&{EMPTY}
    ${response}=    POST    ${URL}    data=${data}
    Status Should Be    ${response_status_code}    ${response}
    RETURN    ${response}

GET API Request And Validate Response Body
    [Arguments]    ${URL}    ${response_status_code}    ${expected_key}
    ${response}=    GET    ${URL}
    Status Should Be    ${response_status_code}    ${response}
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    ${expected_key}
    RETURN    ${response}

GET API Request And Validate Response Code In Body
    [Arguments]    ${URL}    ${expected_response_code}
    ${response}=    GET    ${URL}
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal As Integers    ${json}[responseCode]    ${expected_response_code}
    RETURN    ${response}

POST API Request And Validate Response Code In Body
    [Arguments]    ${URL}    ${expected_response_code}    ${data}=&{EMPTY}
    ${response}=    POST    ${URL}    data=${data}
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal As Integers    ${json}[responseCode]    ${expected_response_code}
    RETURN    ${response}

Validate Response Contains List
    [Arguments]    ${response}    ${list_key}
    ${json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json}    ${list_key}
    ${items}=    Get From Dictionary    ${json}    ${list_key}
    Should Not Be Empty    ${items}
    RETURN    ${items}

Validate Response Message
    [Arguments]    ${response}    ${expected_message}
    ${json}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${json}[message]    ${expected_message}
