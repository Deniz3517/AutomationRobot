*** Settings ***
Documentation   Automation Exercise - Top Panel Object

Library    Browser
Library    String

*** Variables ***

${automation_exercise_home_page_button}      //*[@id="header"]
${automation_exercise_products_button}      //a[@href='/products' and contains(text(), 'Products')]
${automation_exercise_carts_button}        //a[@href='/carts' and contains(text(), 'Carts')]
${automation_exercise_login_button}       //a[@href='/login' and contains(text(), 'Login')]
${automation_exercise_logout_button}     //a[@href='/logout' and contains(text(), 'Logout')]

*** Keywords ***

[Automation Exercise - Top Panel] Is Home Page Button Button Visible
    Wait For Elements State    ${automation_exercise_home_page_button}     visible    timeout=2 s

[Automation Exercise - Top Panel] Click Home Page Button
    Sleep    0.1s
    Click With Options  ${automation_exercise_home_page_button}   force=true

[Automation Exercise - Top Panel] Is Products Button Button Visible
    Wait For Elements State    ${automation_exercise_products_button}     visible    timeout=2 s

[Automation Exercise - Top Panel] Click Products Button
    Sleep    0.1s
    Click With Options  ${automation_exercise_products_button}   force=true

[Automation Exercise - Top Panel] Is Carts Button Button Visible
    Wait For Elements State    ${automation_exercise_carts_button}     visible    timeout=2 s

[Automation Exercise - Top Panel] Click Carts Button
    Sleep    0.1s
    Click With Options  ${automation_exercise_carts_button}   force=true

[Automation Exercise - Top Panel] Is Login Button Button Visible
    Wait For Elements State    ${automation_exercise_login_button}     visible    timeout=2 s

[Automation Exercise - Top Panel] Click Login Button
    Sleep    0.1s
    Click With Options  ${automation_exercise_login_button}   force=true

[Automation Exercise - Top Panel] Is Logout Button Button Visible
    Wait For Elements State    ${automation_exercise_logout_button}     visible    timeout=2 s

[Automation Exercise - Top Panel] Click Logout Button
    Sleep    0.1s
    Click With Options  ${automation_exercise_logout_button}   force=true