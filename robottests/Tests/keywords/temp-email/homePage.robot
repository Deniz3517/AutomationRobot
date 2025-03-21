*** Settings ***
Documentation    Temporary Emil - Home Page Object

Library    Browser
Library    String
Library    Collections

Resource    robottests/Tests/keywords/globalVariables.robot

*** Variables ***
${xpath_refresh_button}           //a[contains(@class,'refresh') and not (contains(@class, 'btn'))]
${xpath_personal_data_consent}    //p[@class='fc-button-label' and contains(text(), 'Consent')]
${xpath_delete_welcome_message}   (//tbody/tr)[1]//a[contains(@href, 'delete')]
${xpath_opened_message_back_btn}   //*[@id='odesilatel']/../preceding-sibling::div

${id_message_iframe}    iframeMail
${id_avatar_img}        avatarImg
${id_received_msg}      schranka
${id_temp_email}        email

*** Keywords ***

[Temp Email - Home Page] Is Message Received By Subject
    [Arguments]    ${subject}
    FOR    ${i}    IN RANGE    15
        ${is_needed_email_received}    Run Keyword And Return Status    Wait For Elements State
        ...    (//td[contains(text(), '${subject}')])[1]    timeout=1 s
        IF    ${is_needed_email_received}
            BREAK
        END
        Click    ${xpath_refresh_button}
    END
    Run Keyword If    not ${is_needed_email_received}    Fail    msg=Needed message with subject '${subject}' was not received!

[Temp Email - Home Page] Open Message By Subject
    [Arguments]    ${subject}
    Sleep    0.4s
    Click    (//td[contains(text(), '${subject}')])[1]

[Temp Email - Home Page] METHOD: Click Link On Opened Message
    ${url}    Get Property    id=${id_message_iframe} >>> xpath=//a    href
    Log To Console    ${url}
    Go To    ${url}

[Temp Email - Home Page] Open New Page By Link In Opened Message
    ${url}    Get Property    id=${id_message_iframe} >>> xpath=//a    href
    Log To Console    ${url}
    New Page    ${url}

[Temp Email - Home Page] Click Back Button In Opened Message
    Sleep    0.3s
    Click    ${xpath_opened_message_back_btn}

[Temp Email - Home Page] Get Body Text Of Opened Messaged
    Sleep    0.4s
    ${body}    Get Text    id=${id_message_iframe} >>> xpath=//body
    RETURN    ${body}

[Temp Email – Home Page] METHOD: Open Home Page
    New Browser    ${BROWSER_TYPE}    headless=true
    ${old_browser_timeout}    Set Browser Timeout    15 seconds
    ${possible_mails}    Create List    ${DISPOSABLEMAIL_LINK}    ${MINUTEINBOX_LINK}    ${FAKEMAIL_LINK}
    FOR    ${temp_mail}    IN    @{possible_mails}
        ${result_mail}    Run Keyword And Return Status    New Page    url=${temp_mail}    wait_until=domcontentloaded
        VAR    ${is_email_visible}    ${False}
        IF    ${result_mail}
            ${is_email_visible}    Run Keyword And Return Status    Wait For Elements State    id=${id_temp_email}    
            ...    visible    timeout=7 s
            IF    ${is_email_visible}
                Set Global Variable    ${MAIL_PORTAL_LINK}    ${temp_mail}
                BREAK
            END
        END
    END
    Set Browser Timeout    ${old_browser_timeout}
    IF    not ${result_mail} or not ${is_email_visible}
        Fail    msg=Portals with temporary mail do not work!
    END
    ${is_consent_needed}    Run Keyword And Return Status    Wait For Elements State    ${xpath_personal_data_consent}
    ...    timeout=2 s
    IF    ${is_consent_needed}
        Sleep    0.4s
        Click With Options    ${xpath_personal_data_consent}    delay=400ms
    END
    ${is_welcome_message_exists}    Run Keyword And Return Status    Wait For Elements State
    ...    ${xpath_delete_welcome_message}    timeout=2 s
    IF    ${is_welcome_message_exists}
        Sleep    0.4s
        Click With Options    ${xpath_delete_welcome_message}    delay=400ms
    END
    Wait For Elements State    id=${id_temp_email}    visible    timeout=2 s

    ${variables}    Get Variables
    Log    ${variables}
    ${is_email_endings_exist}    Run Keyword And Return Status    Should Be True    "\@{TEMP_EMAIL_ENDINGS}" in $variables
    IF    ${is_email_endings_exist}
        ${email_text}    Get Text    id=${id_temp_email}
        ${email_text}    Set Variable    ${email_text.strip()}
        ${email_end}    Get Substring    ${email_text}    ${email_text.find('@')}
        ${is_contain_ending}    Run Keyword And Return Status    Should Contain    ${TEMP_EMAIL_ENDINGS}    ${email_end}
        IF    not ${is_contain_ending}
            Append To List    ${TEMP_EMAIL_ENDINGS}    ${email_end.lower()}
        END
    END

    ${current_page_ids}=   Get Page IDs    ACTIVE    ACTIVE    ACTIVE
    Set Global Variable    ${TEMP_EMAIL_PAGE_ID}    ${current_page_ids}[0]
    ${current_context_ids}=    Get Context Ids    ACTIVE    ACTIVE
    Set Global Variable    ${TEMP_EMAIL_CONTEXT_ID}    ${current_context_ids}[0]
    ${current_browser_ids}=    Get Browser Ids    ACTIVE
    Set Global Variable    ${TEMP_EMAIL_BROWSER_ID}    ${current_browser_ids}[0]
#    Take Screenshot    EMBED

[Temp Email – Home Page] METHOD: Is Home Page Opened
    Wait For Elements State    id=${id_avatar_img}    timeout=5 s

[Temp Email – Home Page] METHOD: Return Email
    ${temp_email_elem}    Get Element    id=${id_temp_email}
    ${temp_email_text}    Get Text    ${temp_email_elem}
    RETURN    ${temp_email_text.strip()}

[Temp Email - Home Page] METHOD: Set TEMP_EMAIL And TEMP_PASS Values
    ${temp_email_elem}    Get Element    id=${id_temp_email}
    ${temp_email_text}    Get Text    ${temp_email_elem}
    Set Global Variable    ${TEMP_EMAIL}    ${temp_email_text.strip()}
    Set Global Variable    ${TEMP_PASS}    Password11qQ!~

[Temp Email - Home Page] METHOD: Open Needed Message
    ${switch_browser_status}    Run Keyword And Return Status    Switch Browser    ${TEMP_EMAIL_BROWSER_ID}
    Run Keyword If    not ${switch_browser_status}    Log    it is not possible to switch browser
    ${switch_context_status}    Run Keyword And Return Status    Switch Context    ${TEMP_EMAIL_CONTEXT_ID}
    Run Keyword If    not ${switch_context_status}    Log    it is not possible to switch context
    ${switch_page_status}    Run Keyword And Return Status    Switch Page    ${TEMP_EMAIL_PAGE_ID}
    Run Keyword If    not ${switch_page_status}    Log    it is not possible to switch page
    Wait For Elements State    ${xpath_refresh_button}    timeout=7s
    FOR    ${i}    IN RANGE    15
        ${is_needed_email_received}    Run Keyword And Return Status    Wait For Elements State    id=${id_received_msg}
        ...    timeout=1 s
        IF    ${is_needed_email_received}
            BREAK
        END
        Click    ${xpath_refresh_button}
#        Take Screenshot    EMBED
    END
    Run Keyword If    '${is_needed_email_received}' == '${False}'    Fail    msg=Needed message is not received!
#    Take Screenshot    EMBED
    Reload
    Wait For Elements State    id=${id_received_msg}    timeout=5 s
    Sleep    0.5s
    Click    id=${id_received_msg}
    Sleep    0.3s
#    Take Screenshot    EMBED
