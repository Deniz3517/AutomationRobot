*** Settings ***
Documentation    Automation Exercise - Product Detail Page Object

Library    Browser

*** Variables ***
${automation_exercise_product_info_name}        //div[@class='product-information']//h2
${automation_exercise_product_info_price}       //div[@class='product-information']//span[@class='price']//span
${automation_exercise_quantity_input}           //input[@id='quantity']
${automation_exercise_add_to_cart_button}       //button[@class='btn btn-default cart']
${automation_exercise_cart_modal_continue}      //button[normalize-space()='Continue Shopping']
${automation_exercise_cart_modal_view_cart}     //u[normalize-space()='View Cart']

*** Keywords ***
[Automation Exercise – Product Detail Page] Is Page Opened
    Wait Until Keyword Succeeds    10s    0.5s    Get Url    contains    /product_details/

[Automation Exercise – Product Detail Page] Is Product Name Visible
    Wait For Elements State    ${automation_exercise_product_info_name}    visible    timeout=7 s

[Automation Exercise – Product Detail Page] Set Quantity
    [Arguments]    ${quantity}
    Wait For Elements State    ${automation_exercise_quantity_input}    visible    timeout=5 s
    Fill Text    ${automation_exercise_quantity_input}    ${quantity}

[Automation Exercise – Product Detail Page] Click Add To Cart
    Wait For Elements State    ${automation_exercise_add_to_cart_button}    visible    timeout=5 s
    Sleep    0.1s
    Click With Options    ${automation_exercise_add_to_cart_button}    force=true

[Automation Exercise – Product Detail Page] Click Continue Shopping
    Wait For Elements State    ${automation_exercise_cart_modal_continue}    visible    timeout=5 s
    Sleep    0.1s
    Click With Options    ${automation_exercise_cart_modal_continue}    force=true
