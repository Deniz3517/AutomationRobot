*** Settings ***
Documentation    Automation Exercise - Home Page Object

Library    Browser

*** Variables ***
${automation_exercise_cookie_consent_btn}    //p[@class='fc-button-label' and contains(text(), 'Consent')]

*** Keywords ***
[Automation Exercise – Home Page] Open Automation Exercise Home Page
    [Arguments]    ${URL}
    New Browser    ${BROWSER_TYPE}    headless=false    downloadsPath=.    args=["--disable-web-security"]
    Set Log Level    WARN
    New Context    acceptDownloads=true
    Set Log Level    INFO
    New Page    ${URL}
    Sleep    1.5s
    [Automation Exercise – Home Page] Accept Cookie Consent

[Automation Exercise – Home Page] Accept Cookie Consent
    ${is_consent}=    Run Keyword And Return Status    Wait For Elements State
    ...    ${automation_exercise_cookie_consent_btn}    visible    timeout=5s
    IF    ${is_consent}
        Click    ${automation_exercise_cookie_consent_btn}
        Sleep    0.5s
    END

[Automation Exercise – Home Page] Is Page Opened
    Wait Until Keyword Succeeds    10s    0.5s    Get Url    contains    automationexercise.com
