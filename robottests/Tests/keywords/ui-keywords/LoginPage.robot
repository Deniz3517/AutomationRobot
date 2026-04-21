*** Settings ***
Documentation    Automation Exercise - Login Page Object

Library    Browser

*** Variables ***

${automation_excercise_login_page_id_email_input}         //input[@data-qa='login-email']
${automation_excercise_login_page_id_password_input}      //input[@data-qa='login-password']
${automation_excercise_page_xpath_sign_in_button}         //button[@data-qa='login-button']

*** Keywords ***

[Automation Exercise – Login Page] Is Page Opened
    Wait Until Keyword Succeeds    10s    0.5s    Get Url    should end with    /login


[Automation Exercise – Login Page] Log In To Automation Exercise
    [Arguments]    ${email}    ${password}
    Type Text    ${automation_excercise_login_page_id_email_input}    ${email}
    Type Secret    ${automation_excercise_login_page_id_password_input}    $password
    Sleep    0.15s
    Click       ${automation_excercise_page_xpath_sign_in_button}

[Automation Exercise – Login Page] Click Sign Up Button
    Click       ${automation_excercise_page_xpath_sign_in_button}
