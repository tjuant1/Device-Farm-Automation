*** Settings ***

Resource    ../config/robot/resources.resource

*** Test Cases ***
Register Demoblaze
    ${url}=    Set Variable    ${perfecto['url']}
    ${perfecto-token}    Set Variable    ${perfecto['token']}

    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    Call Method    ${chrome_options}    set_capability    perfecto:deviceName         1B091FDF60089S
    Call Method    ${chrome_options}    set_capability    perfecto:securityToken      ${perfecto-token}
    Call Method    ${chrome_options}    set_capability    automationName              UiAutomator2
    Call Method    ${chrome_options}    set_capability    browserName                 Chrome
    Call Method    ${chrome_options}    add_argument      --disable-notifications
    Call Method    ${chrome_options}    add_experimental_option    prefs    {"profile.default_content_setting_values.notifications": 2}

    Open Browser    https://www.demoblaze.com/    chrome
    ...    remote_url=${url}
    ...    options=${chrome_options}
    
    ${username}=    Word
    ${password}=    Password

    Sleep    10

    Click Element    ${elements['signin2_a']}
    Input Text       ${elements['sign-username_input']}    ${username.lower()}
    Input Text       ${elements['sign-password_input']}    ${password}
    Click Button     ${elements['sign up_button']}