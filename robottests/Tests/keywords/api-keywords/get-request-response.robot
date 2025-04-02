*** Settings ***
Library    Browser
Library    RequestsLibrary

Documentation    API Requests and Responses

*** Variables ***

*** Keywords ***
GET API Request
    [Arguments]    ${URL}    ${response_status_code}
    ${log_level}    Set Log Level    WARN
    ${response}=    GET    ${URL}
    Set Log Level    INFO
    status should be    ${response_status_code}    ${response}
