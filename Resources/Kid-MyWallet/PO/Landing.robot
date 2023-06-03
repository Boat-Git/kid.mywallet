*** Settings ***
Library         SeleniumLibrary
Resource        ${EXECDIR}/Resources/Common/getCss.robot

*** Variables ***
${LANDING_LOGO_IMAGE} =                 xpath=//div[@class="text-center"]/img
${LANDING_USERNAME_TEXTBOX} =           xpath=//input[@name="name"]
${LANDING_PASSWORD_TEXTBOX} =           xpath=//input[@name="password"]
${LANDING_LOGIN_BUTTON} =               xpath=//button[@class="login100-form-btn"]

*** Keywords ***
Navigate To
    Go to                               ${BASE_URL.${ENVIRONMENT}}

###################################################################
######                     Verifications                      #####
###################################################################
Verify Page Loaded
    Wait Until Element Is Enabled       ${LANDING_LOGO_IMAGE}

Verify Expected Error
    [Arguments]     ${credentials}
    IF  "${credentials.ExpectedErrorMessage}" != "${EMPTY}"
        Wait Until Page Contains        ${credentials.ExpectedErrorMessage}
    ELSE
        IF  "${credentials.Username}" == "${EMPTY}"
            ${element_prop} =   getCss.Get CSS Property Value  xpath=/html/body/div/div/div/form/div[2]  border
            Should Be Equal As Strings   ${element_prop}  0.8px solid rgb(230, 130, 122)
        END
        IF  "${credentials.Password}" == "${EMPTY}"
            ${element_prop} =   getCss.Get CSS Property Value  xpath=/html/body/div/div/div/form/div[3]  border
            Should Be Equal As Strings   ${element_prop}  0.8px solid rgb(230, 130, 122)
        END
    END

###################################################################
######                        Actions                         #####
###################################################################
Enter Credentials
    [Arguments]     ${credentials}
    IF  "${credentials.Username}" != "${EMPTY}"
        Enter "Username" Field          ${credentials.Username}
    END
    IF  "${credentials.Password}" != "${EMPTY}"
        Enter "Password" Field          ${credentials.Password}
    END

Enter "Username" Field
    [Arguments]     ${username}
    Input Text                          ${LANDING_USERNAME_TEXTBOX}   ${username}

Enter "Password" Field
    [Arguments]     ${password}
    Input Password                      ${LANDING_PASSWORD_TEXTBOX}   ${password}

Click "Login" Button
    Click Button                        ${LANDING_LOGIN_BUTTON}

# Enter Valid Credentials
#     [Arguments]     ${username}     ${password}
#     Enter "Username" Field              ${username}
#     Enter "Password" Field              ${password}