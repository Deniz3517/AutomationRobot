*** Settings ***
Documentation    Automation Exercise - Cart Page Object

Library    Browser

*** Variables ***
${automation_exercise_cart_empty_message}       //b[normalize-space()='Cart is empty!']
${automation_exercise_cart_product_row}         //tr[@class='cart_menu']
${automation_exercise_cart_proceed_checkout}    //a[normalize-space()='Proceed To Checkout']

*** Keywords ***
[Automation Exercise – Cart Page] Is Page Opened
    Wait Until Keyword Succeeds    10s    0.5s    Get Url    should end with    /view_cart

[Automation Exercise – Cart Page] Is Cart Empty Message Visible
    Wait For Elements State    ${automation_exercise_cart_empty_message}    visible    timeout=5 s

[Automation Exercise – Cart Page] Is Cart Table Visible
    Wait For Elements State    ${automation_exercise_cart_product_row}    visible    timeout=7 s
