*** Settings ***
Documentation       Use this layer to set test set up & tear down
Library             SeleniumLibrary

*** Keywords ***

Begin Web Test
    #Initialize Selenium
    Set Selenium speed          .2s
    Set Selenium timeout        10s
    Open BROWSER                about:blank     ${BROWSER}
    Maximize Browser Window

Reload Web Test
    Reload Page

End Web Test
    Close All Browsers