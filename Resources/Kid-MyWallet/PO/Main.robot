*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${MAIN_HEADER_LABEL} =                  xpath=//div[@class="name"]

*** Keywords ***

Verify Page Loaded
    Wait Until Element Is Enabled       ${MAIN_HEADER_LABEL}