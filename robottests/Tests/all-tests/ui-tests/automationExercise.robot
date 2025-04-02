*** Settings ***

Library      Browser
Library      Collections

Resource    ../../keywords/ui-keywords/topPanel.robot
Resource    ../../keywords/ui-keywords/homePage.robot
Resource    ../../keywords/ui-keywords/globalVariables.robot
Resource    ../../keywords/temp-email/homePage.robot
Resource    ../../keywords/ui-keywords/LoginPage.robot
*** Variables ***
${BROWSER_TYPE}   chromium

*** Keywords ***

Setup Action
    Set Log Level    WARN
    [Temp Email – Home Page] METHOD: Open Home Page
    [Temp Email – Home Page] METHOD: Open Home Page
    [Temp Email - Home Page] METHOD: Set TEMP_EMAIL And TEMP_PASS Values
    ${temp_email_len}    Get Length    ${TEMP_EMAIL}
    IF    ${temp_email_len} < ${1}
    [Temp Email – Home Page] METHOD: Open Home Page
    [Temp Email - Home Page] METHOD: Set TEMP_EMAIL And TEMP_PASS Values
    ${temp_email_len}    Get Length    ${TEMP_EMAIL}
    Run Keyword If    ${temp_email_len} < ${1}    Fail    msg=Something wrong with temporary email after two attempts!
    END


*** Test Cases ***
[Automation Robot] Automation Exercise - Login Test
    [Tags]    UI    SMOKE    REGRESSION   TEST-1
    Setup Action
    [Automation Exercise – Home Page] Open Automation Exercise Home Page      ${AUTOMATIONEXERCISE_LINK}
    [Automation Exercise – Home Page] Is Page Opened
    [Automation Exercise - Top Panel] Is Login Button Button Visible
    [Automation Exercise - Top Panel] Click Login Button
    [Automation Exercise – Login Page] Is Page Opened
    [Automation Exercise – Login Page] Log In To Automation Exercise    ${TEMP_EMAIL}    ${TEMP_PASS}
    [Automation Exercise - Top Panel] Is Logout Button Button Visible
    [Automation Exercise - Top Panel] Click Logout Button

    [Teardown]    Close Browser    ALL



