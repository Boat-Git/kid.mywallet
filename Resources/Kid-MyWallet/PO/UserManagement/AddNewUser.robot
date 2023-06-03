*** Settings ***
Library         SeleniumLibrary
Resource        ${EXECDIR}/Resources/Common/getCss.robot

*** Variables ***
${ADD_NEW_USER_HEADER_LABEL} =             xpath=//h3[contains(text(),"New User")]
${ADD_NEW_USER_USERNAME_TEXTBOX} =         name=username
${ADD_NEW_USER_PASSWORD_TEXTBOX} =         name=password
${ADD_NEW_USER_FULLNAME_TEXTBOX} =         name=full_name
${ADD_NEW_USER_ROLE_DROPDOWN} =            name=role_id
${ADD_NEW_USER_MOBILE_TEXTBOX} =           name=mobile
${ADD_NEW_USER_EMAIL_TEXTBOX} =            name=email
${ADD_NEW_USER_STATUS_RADIO} =             status
${ADD_NEW_USER_ACTIVE_RADIO} =             xpath=//div[input[@id="status1"]]
${ADD_NEW_USER_INACTIVE_RADIO} =           xpath=//div[input[@id="status2"]]
${ADD_NEW_USER_SAVE_BUTTON} =              id=save_from
${ADD_NEW_USER_CLOSE_BUTTON} =             xpath=//button[contains(text(),"Close")]

*** Keywords ***
###################################################################
######                     Verifications                      #####
###################################################################
Verify Page Loaded
    Wait Until Element Is Visible       ${ADD_NEW_USER_HEADER_LABEL}
    Element Should Contain              ${ADD_NEW_USER_HEADER_LABEL}    New User

Verify Expected Results
    [Arguments]     ${username}  ${fullname}  ${role}  ${expect_msg}
    IF  "${expect_msg}" != "${EMPTY}"
        Wait Until Page Contains        ${expect_msg}
    ELSE
        Verify Required Field    ${username}  ${fullname}  ${role}
    END

Verify Required Field
    [Arguments]     ${username}  ${fullname}  ${role}
    IF  "${username}" == "${EMPTY}"
        ${element_prop} =   getCss.Get CSS Property Value  ${ADD_NEW_USER_USERNAME_TEXTBOX}  border-color
        Should Be Equal As Strings   ${element_prop}  rgb(220, 53, 69)
    END
    IF  "${fullname}" == "${EMPTY}"
        ${element_prop} =   getCss.Get CSS Property Value  ${ADD_NEW_USER_FULLNAME_TEXTBOX}  border-color
        Should Be Equal As Strings   ${element_prop}  rgb(220, 53, 69)
    END
    IF  "${role}" == "${EMPTY}"
        Wait Until Page Contains            Please Select Role Permission
    END

###################################################################
######                        Actions                         #####
###################################################################
Input User Information
    [Arguments]     ${username}  ${password}  ${fullname}  ${role}  ${mobile}  ${email}  ${status}
    IF  "${username}" != "${EMPTY}"
        Enter "Username" Field                ${username}
    END
    IF  "${password}" != "${EMPTY}"
        Enter "Password" Field                ${password}
    END
    IF  "${fullname}" != "${EMPTY}"
        Enter "Full Name" Field               ${fullname}
    END
    IF  "${role}" != "${EMPTY}"
        Select "Role" In Dropdown-list        ${role}
    END
    IF  "${mobile}" != "${EMPTY}"
        Enter "Mobile" Field                  ${mobile}
    END
    IF  "${email}" != "${EMPTY}"
        Enter "Email" Field                   ${email}
    END
    Select "Status" In Radio Button           ${status}

Enter "Username" Field
    [Arguments]     ${username}
    Input Text                          ${ADD_NEW_USER_USERNAME_TEXTBOX}    ${username}

Enter "Password" Field
    [Arguments]     ${password}
    Input Text                          ${ADD_NEW_USER_PASSWORD_TEXTBOX}    ${password}

Enter "Full Name" Field
    [Arguments]     ${fullname}
    Input Text                          ${ADD_NEW_USER_FULLNAME_TEXTBOX}    ${fullname}

Select "Role" In Dropdown-list
    [Arguments]     ${role}
    Select From List By Label           ${ADD_NEW_USER_ROLE_DROPDOWN}       ${role}

Enter "Mobile" Field
    [Arguments]     ${mobile}
    Input Text                          ${ADD_NEW_USER_MOBILE_TEXTBOX}      ${mobile}

Enter "Email" Field
    [Arguments]     ${email}
    Input Text                          ${ADD_NEW_USER_EMAIL_TEXTBOX}       ${email}

Select "Status" In Radio Button
    [Arguments]     ${status}
    IF  "${status}" == "1"
        Click Element                   ${ADD_NEW_USER_ACTIVE_RADIO}
    ELSE
        Click Element                   ${ADD_NEW_USER_INACTIVE_RADIO}
    END

Click "Save" Button
    Click Button                        ${ADD_NEW_USER_SAVE_BUTTON}

Click "Close" Button
    Click Button                        ${ADD_NEW_USER_CLOSE_BUTTON}