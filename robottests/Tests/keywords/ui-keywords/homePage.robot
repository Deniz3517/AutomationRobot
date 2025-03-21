*** Settings ***
Documentation    Automation Exercise - Home Page Object

Library    Browser

*** Variables ***

*** Keywords ***
[Automation Exercise – Home Page] Open Education Home Page
    [Arguments]    ${URL}
    New Browser    ${BROWSER_TYPE}    headless=true    downloadsPath=.    args=["--disable-web-security"]
    Set Log Level    WARN
    New Context    acceptDownloads=true
    Set Log Level    INFO
    New Page    ${URL}
    Sleep    0.3s
#    Take Screenshot    EMBED

[Automation Exercise – Home Page] Is Page Opened
    Sleep    0.3s
    Get Url    should end with    /home
