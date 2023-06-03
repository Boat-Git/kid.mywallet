*** Settings ***
Library         SeleniumLibrary
Library         String
Resource        ${EXECDIR}/Resources/Common/getCss.robot

*** Variables ***
${EDIT_USER_ID_LABEL} =                 xpath=//h3[contains(text(),"User ID:")]
${EDIT_USER_USERNAME_TEXTBOX} =         name=username
${EDIT_USER_FULLNAME_TEXTBOX} =         name=full_name
${EDIT_USER_ROLE_DROPDOWN} =            name=role_id
${EDIT_USER_MOBILE_TEXTBOX} =           name=mobile
${EDIT_USER_EMAIL_TEXTBOX} =            name=email
${EDIT_USER_STATUS_RADIO} =             status
${EDIT_USER_ACTIVE_RADIO} =             xpath=//div[input[@id="status1"]]
${EDIT_USER_INACTIVE_RADIO} =           xpath=//div[input[@id="status2"]]
${EDIT_USER_SAVE_BUTTON} =              id=save_from
${EDIT_USER_CLOSE_BUTTON} =             xpath=//button[contains(text(),"Close")]

*** Keywords ***

###################################################################
######                     Verifications                      #####
###################################################################
Verify Page Loaded
    Wait Until Element Is Visible       ${EDIT_USER_ID_LABEL}
    Element Should Contain              ${EDIT_USER_ID_LABEL}    User ID:

Verify User Updated Successfully
    [Arguments]  ${username}  ${fullname}  ${role}  ${mobile}  ${email}  ${status}
    Wait Until Element Is Visible       ${EDIT_USER_USERNAME_TEXTBOX}
    Textfield Should Contain            ${EDIT_USER_USERNAME_TEXTBOX}   ${username}
    Wait Until Element Is Visible       ${EDIT_USER_FULLNAME_TEXTBOX}
    Textfield Should Contain            ${EDIT_USER_FULLNAME_TEXTBOX}   ${fullname}
    Wait Until Element Is Visible       ${EDIT_USER_ROLE_DROPDOWN}
    List Selection Should Be            ${EDIT_USER_ROLE_DROPDOWN}      ${role}
    Wait Until Element Is Visible       ${EDIT_USER_MOBILE_TEXTBOX}
    Textfield Should Contain            ${EDIT_USER_MOBILE_TEXTBOX}     ${mobile}
    Wait Until Element Is Visible       ${EDIT_USER_EMAIL_TEXTBOX}
    Textfield Should Contain            ${EDIT_USER_EMAIL_TEXTBOX}      ${email}
    Radio Button Should Be Set To       ${EDIT_USER_STATUS_RADIO}       ${status}

Verify Required Field
    [Arguments]     ${username}  ${fullname}  ${role}
    IF  "${username}" == "${EMPTY}"
        ${element_prop} =   getCss.Get CSS Property Value  ${EDIT_USER_USERNAME_TEXTBOX}  border-color
        Should Be Equal As Strings   ${element_prop}  rgb(220, 53, 69)
    END
    IF  "${fullname}" == "${EMPTY}"
        ${element_prop} =   getCss.Get CSS Property Value  ${EDIT_USER_FULLNAME_TEXTBOX}  border-color
        Should Be Equal As Strings   ${element_prop}  rgb(220, 53, 69)
    END
    IF  "${role}" == "Please Select Role Permission"
        Wait Until Page Contains            Please Select Role Permission
    END

###################################################################
######                        Actions                         #####
###################################################################
Update User Information
    [Arguments]     ${edit_data}
    Clear Input Fields  ${edit_data}
    IF  "${edit_data[2]}" != "${EMPTY}"
        Enter "Username" Field              ${edit_data[2]}
    END
    IF  "${edit_data[3]}" != "${EMPTY}"
        Enter "Full Name" Field             ${edit_data[3]}
    END
    IF  "${edit_data[4]}" != "${EMPTY}"
        Select "Role" In Dropdown-list      ${edit_data[4]}
    END
    IF  "${edit_data[5]}" != "${EMPTY}"
        Enter "Mobile" Field                ${edit_data[5]}
    END
    IF  "${edit_data[6]}" != "${EMPTY}"
        Enter "Email" Field                 ${edit_data[6]}
    END
    Select "Status" In Radio Button         ${edit_data[7]}

Clear Input Fields
    [Arguments]     ${edit_data}
    IF  "${edit_data[2]}" == "${EMPTY}"
        Clear Element Text                  ${EDIT_USER_USERNAME_TEXTBOX}
    END
    IF  "${edit_data[3]}" == "${EMPTY}"
        Clear Element Text                  ${EDIT_USER_FULLNAME_TEXTBOX}
    END
    IF  "${edit_data[5]}" == "${EMPTY}"
        Clear Element Text                  ${EDIT_USER_MOBILE_TEXTBOX}
    END
    IF  "${edit_data[6]}" == "${EMPTY}"
        Clear Element Text                  ${EDIT_USER_EMAIL_TEXTBOX}
    END

Enter "Username" Field
    [Arguments]     ${username}
    Input Text                              ${EDIT_USER_USERNAME_TEXTBOX}    ${username}

Enter "Full Name" Field
    [Arguments]     ${fullname}
    Input Text                              ${EDIT_USER_FULLNAME_TEXTBOX}    ${fullname}

Select "Role" In Dropdown-list
    [Arguments]     ${role}
    Select From List By Label               ${EDIT_USER_ROLE_DROPDOWN}       ${role}

Enter "Mobile" Field
    [Arguments]     ${mobile}
    Input Text                              ${EDIT_USER_MOBILE_TEXTBOX}      ${mobile}

Enter "Email" Field
    [Arguments]     ${email}
    Input Text                              ${EDIT_USER_EMAIL_TEXTBOX}       ${email}

Select "Status" In Radio Button
    [Arguments]     ${status}
    IF  "${status}" == "1"
        Click Element                       ${EDIT_USER_ACTIVE_RADIO}
    ELSE
        Click Element                       ${EDIT_USER_INACTIVE_RADIO}
    END

Click "Save" Button
    Click Button                            ${EDIT_USER_SAVE_BUTTON}

Click "Close" Button
    Click Button                            ${EDIT_USER_CLOSE_BUTTON}