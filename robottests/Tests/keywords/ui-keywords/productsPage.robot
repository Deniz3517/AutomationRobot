*** Settings ***
Documentation    Automation Exercise - Products Page Object

Library    Browser

*** Variables ***
${automation_exercise_all_products_heading}         //h2[normalize-space()='All Products']
${automation_exercise_search_input}                 //input[@id='search_product']
${automation_exercise_search_button}                //button[@id='submit_search']
${automation_exercise_searched_products_heading}    //h2[normalize-space()='Searched Products']
${automation_exercise_first_view_product_link}      (//a[contains(@href,'/product_details/')])[1]

*** Keywords ***
[Automation Exercise – Products Page] Is Page Opened
    Wait Until Keyword Succeeds    10s    0.5s    Get Url    should end with    /products

[Automation Exercise – Products Page] Is All Products Heading Visible
    Wait For Elements State    ${automation_exercise_all_products_heading}    visible    timeout=7 s

[Automation Exercise – Products Page] Search Product
    [Arguments]    ${search_term}
    Wait For Elements State    ${automation_exercise_search_input}    visible    timeout=5 s
    Type Text    ${automation_exercise_search_input}    ${search_term}
    Sleep    0.1s
    Click With Options    ${automation_exercise_search_button}    force=true

[Automation Exercise – Products Page] Is Searched Products Heading Visible
    Wait For Elements State    ${automation_exercise_searched_products_heading}    visible    timeout=7 s

[Automation Exercise – Products Page] Click First View Product
    Wait For Elements State    ${automation_exercise_first_view_product_link}    visible    timeout=5 s
    Sleep    0.1s
    Click With Options    ${automation_exercise_first_view_product_link}    force=true
