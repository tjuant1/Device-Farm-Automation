*** Settings ***

Resource    ../config/robot/resources.resource

Suite Teardown    Run Keywords
...    Capture Page Screenshot    AND
...    Close Browser

*** Test Cases ***
Register Demoblaze
    ${url}=    Set Variable    ${perfecto['url']}
    ${perfecto-token}    Set Variable    ${perfecto['token']}

    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    #To Run on Virtual Devices:
    # Call Method    ${chrome_options}    set_capability    perfecto:platformName         Android
    # Call Method    ${chrome_options}    set_capability    perfecto:platformVersion      14
    # Call Method    ${chrome_options}    set_capability    perfecto:model                pixel 6 pro
    # Call Method    ${chrome_options}    set_capability    perfecto:useVirtualDevice     ${True}

    #To Run on Phisical Devices:
    Call Method    ${chrome_options}    set_capability    perfecto:deviceName         27021FDH30022D

    #Capabilities:
    Call Method    ${chrome_options}    set_capability    perfecto:securityToken        ${perfecto-token}
    Call Method    ${chrome_options}    set_capability    automationName                UiAutomator2
    Call Method    ${chrome_options}    set_capability    browserName                   Chrome
    Call Method    ${chrome_options}    set_capability    browserVersion                135.0.7049.95
    Call Method    ${chrome_options}    add_argument      --disable-notifications

    Open Browser    https://www.demoblaze.com/    chrome
    ...    remote_url=${url}
    ...    options=${chrome_options}
    
    ${word1}=    Word
    ${word2}=    Word

    ${username}=    Set Variable    ${word1}${word2}
    ${password}=    Password

    Sleep    10

    Click Element        ${elements['signin2_a']}
    Input Text           ${elements['sign-username_input']}    ${username.lower()}
    Input Password       ${elements['sign-password_input']}    ${password}
    Click Button         ${elements['sign up_button']}

    Run Keyword And Ignore Error    Handle Alert    ACCEPT
    Sleep    1

    Click Element        ${elements['login2_a']}
    Input Text           ${elements['loginusername_input']}    ${username}
    Input Password       ${elements['loginpassword_input']}    ${password}
    Click Button         ${elements['login_button']}

    Sleep    1
    Scroll Element Into View        ${elements['galaxy_s6']}
    Click Element        ${elements['galaxy_s6']}

    Scroll Element Into View        ${elements['add_cart']}
    Wait Until Element Is Visible    ${elements['add_cart']}
    Click Element        ${elements['add_cart']}
    Sleep    2
    
    Run Keyword And Ignore Error    Handle Alert    ACCEPT

    Click Element        ${elements['cart']}
    Wait Until Element Is Visible    ${elements['delete_cart']}
