*** Settings ***

Library      Browser
Library      Collections

Resource    ../../keywords/ui-keywords/topPanel.robot
Resource    ../../keywords/ui-keywords/homePage.robot
Resource    ../../keywords/ui-keywords/globalVariables.robot
Resource    ../../keywords/temp-email/homePage.robot
Resource    ../../keywords/ui-keywords/LoginPage.robot
Resource    ../../keywords/ui-keywords/productsPage.robot
Resource    ../../keywords/ui-keywords/productDetailPage.robot
Resource    ../../keywords/ui-keywords/contactUsPage.robot
Resource    ../../keywords/ui-keywords/cartPage.robot
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

[Automation Robot] Automation Exercise - All Products Page Test
    [Tags]    UI    SMOKE    REGRESSION    TEST-2
    [Automation Exercise – Home Page] Open Automation Exercise Home Page    ${AUTOMATIONEXERCISE_LINK}
    [Automation Exercise – Home Page] Is Page Opened
    [Automation Exercise - Top Panel] Is Products Button Button Visible
    [Automation Exercise - Top Panel] Click Products Button
    [Automation Exercise – Products Page] Is Page Opened
    [Automation Exercise – Products Page] Is All Products Heading Visible
    [Teardown]    Close Browser    ALL

[Automation Robot] Automation Exercise - Search Product Test
    [Tags]    UI    SMOKE    REGRESSION    TEST-3
    [Automation Exercise – Home Page] Open Automation Exercise Home Page    ${AUTOMATIONEXERCISE_LINK}
    [Automation Exercise – Home Page] Is Page Opened
    [Automation Exercise - Top Panel] Click Products Button
    [Automation Exercise – Products Page] Is Page Opened
    [Automation Exercise – Products Page] Is All Products Heading Visible
    [Automation Exercise – Products Page] Search Product    Top
    [Automation Exercise – Products Page] Is Searched Products Heading Visible
    [Teardown]    Close Browser    ALL

[Automation Robot] Automation Exercise - Product Detail Page Test
    [Tags]    UI    SMOKE    REGRESSION    TEST-4
    [Automation Exercise – Home Page] Open Automation Exercise Home Page    ${AUTOMATIONEXERCISE_LINK}
    [Automation Exercise – Home Page] Is Page Opened
    [Automation Exercise - Top Panel] Click Products Button
    [Automation Exercise – Products Page] Is Page Opened
    [Automation Exercise – Products Page] Is All Products Heading Visible
    [Automation Exercise – Products Page] Click First View Product
    [Automation Exercise – Product Detail Page] Is Page Opened
    [Automation Exercise – Product Detail Page] Is Product Name Visible
    [Automation Exercise – Product Detail Page] Set Quantity    2
    [Automation Exercise – Product Detail Page] Click Add To Cart
    [Automation Exercise – Product Detail Page] Click Continue Shopping
    [Teardown]    Close Browser    ALL

[Automation Robot] Automation Exercise - Cart Page Test
    [Tags]    UI    SMOKE    TEST-5
    [Automation Exercise – Home Page] Open Automation Exercise Home Page    ${AUTOMATIONEXERCISE_LINK}
    [Automation Exercise – Home Page] Is Page Opened
    [Automation Exercise - Top Panel] Is Carts Button Button Visible
    [Automation Exercise - Top Panel] Click Carts Button
    [Automation Exercise – Cart Page] Is Page Opened
    [Teardown]    Close Browser    ALL

[Automation Robot] Automation Exercise - Contact Us Form Test
    [Tags]    UI    SMOKE    REGRESSION    TEST-6
    [Automation Exercise – Home Page] Open Automation Exercise Home Page    ${AUTOMATIONEXERCISE_LINK}
    [Automation Exercise – Home Page] Is Page Opened
    Go To    ${AUTOMATIONEXERCISE_LINK}contact_us
    [Automation Exercise – Contact Us Page] Is Page Opened
    [Automation Exercise – Contact Us Page] Fill Contact Form
    ...    Test User
    ...    testuser@example.com
    ...    Automation Test Subject
    ...    This is an automated test message sent by Robot Framework.
    [Automation Exercise – Contact Us Page] Click Submit
    [Automation Exercise – Contact Us Page] Is Success Alert Visible
    [Teardown]    Close Browser    ALL

