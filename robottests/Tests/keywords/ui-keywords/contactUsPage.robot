*** Settings ***
Documentation    Automation Exercise - Contact Us Page Object

Library    Browser

*** Variables ***
${automation_exercise_contact_name_input}       //input[@data-qa='name']
${automation_exercise_contact_email_input}      //input[@data-qa='email']
${automation_exercise_contact_subject_input}    //input[@data-qa='subject']
${automation_exercise_contact_message_input}    //textarea[@data-qa='message']
${automation_exercise_contact_submit_button}    //input[@data-qa='submit-button']
${automation_exercise_contact_success_alert}    //*[@id='contact-page']//div[contains(@class,'alert-success')]
${automation_exercise_contact_home_button}      //a[normalize-space()='Home']

*** Keywords ***
[Automation Exercise – Contact Us Page] Is Page Opened
    Sleep    0.3s
    Get Url    should end with    /contact_us

[Automation Exercise – Contact Us Page] Fill Contact Form
    [Arguments]    ${name}    ${email}    ${subject}    ${message}
    Wait For Elements State    ${automation_exercise_contact_name_input}    visible    timeout=5 s
    Type Text    ${automation_exercise_contact_name_input}    ${name}
    Type Text    ${automation_exercise_contact_email_input}    ${email}
    Type Text    ${automation_exercise_contact_subject_input}    ${subject}
    Type Text    ${automation_exercise_contact_message_input}    ${message}

[Automation Exercise – Contact Us Page] Click Submit
    Sleep    0.1s
    Evaluate JavaScript    ${None}    () => { window.confirm = () => true; window.alert = () => true; }
    Click With Options    ${automation_exercise_contact_submit_button}    force=true

[Automation Exercise – Contact Us Page] Is Success Alert Visible
    Wait For Elements State    ${automation_exercise_contact_success_alert}    visible    timeout=7 s

[Automation Exercise – Contact Us Page] Click Home Button
    Wait For Elements State    ${automation_exercise_contact_home_button}    visible    timeout=5 s
    Sleep    0.1s
    Click With Options    ${automation_exercise_contact_home_button}    force=true
