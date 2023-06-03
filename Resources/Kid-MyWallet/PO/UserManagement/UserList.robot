*** Settings ***
Library         SeleniumLibrary
Library         DateTime
Library         BuiltIn
Library         String

*** Variables ***
# Locators for search form
${USER_LIST_HEADER_LABEL} =                     //h3[contains(text(),"User Management")]
${USER_LIST_ADD_NEW_USER_LINK} =                id=create_new
${USER_LIST_RESET_BUTTON} =                     xpath=//button[contains(text(),"Reset")]
${USER_LIST_SEARCH_BUTTON} =                    xpath=//button[contains(text(),"Search")]
${USER_LIST_USER_NAME_TEXTBOX} =                name=filter[username]
${USER_LIST_FULL_NAME_TEXTBOX} =                name=filter[full_name]
${USER_LIST_ROLE_DROPDOWN} =                    xpath=//select[@name="filter[role_id]"]
${USER_LIST_STATUS_DROPDOWN} =                  xpath=//select[@name="filter[status]"]
${USER_LIST_STATUS_DROPDOWN} =                  id=select2-filterstatus-5n-container

# Locators for datepicker
${USER_LIST_FROM_DATE_TEXTBOX} =                name=filter[update_date][from]
${USER_LIST_TO_DATE_TEXTBOX} =                  name=filter[update_date][to]
${USER_LIST_DATE_PICKER_TITLE} =                xpath=//div[contains(@class,"datepicker") and contains(@class,"active")]//div[@class="datepicker--nav-title"]
${USER_LIST_DATE_PICKER_LEFT_ARROW} =           xpath=//div[contains(@class,"datepicker") and contains(@class,"active")]//div[@data-action="prev"]
${USER_LIST_DATE_PICKER_RIGHT_ARROW} =          xpath=//div[contains(@class,"datepicker") and contains(@class,"active")]//div[@data-action="next"]

# Locators for table and dialog boxes
${USER_LIST_EDIT_ICON} =                        xpath=//i[contains(@class,"icon-pencil")]
${USER_LIST_RESET_PASSWORD_ICON} =              xpath=//i[contains(@class,"icon-key")]
${USER_LIST_REMOVE_ICON} =                      xpath=//i[contains(@class,"icon-trash")]
${USER_LIST_HEADER_POPUP_DELETE_LABEL} =        xpath=//div[contains(text(),"Are you sure you want to delete this?")]
${USER_LIST_CONFIRM_DELETE_BUTTON} =            xpath=//button[contains(text(),"Confirm")]
${USER_LIST_CANCEL_DELETE_BUTTON} =             xpath=//div[@class="swal-button-container"][button[contains(text(),"Cancel")]]
${USER_LIST_HEADER_POPUP_RESET_PW_LABEL} =      id=CategoryLabel
${USER_LIST_SAVE_RESET_PASSWORD_BUTTON} =       id=set_new_password
${USER_LIST_CANCEL_RESET_PASSWORD_BUTTON} =     xpath=//form[@id="form_reset_pwd"]/div/button[contains(text(),"Cancel")]
${USER_LIST_NO_MATCHING_LABEL} =                No matching records found

*** Keywords ***

###################################################################
######                     Verifications                      #####
###################################################################
Verify Page Loaded
    Wait Until Element Is Visible           ${USER_LIST_HEADER_LABEL}
    Element Should Contain                  ${USER_LIST_HEADER_LABEL}    User Management

Verify Search Result Completed
    [Arguments]     ${search_term}
    Wait Until Element Is Visible               xpath=//table[@id="datatable_list"]/tbody/tr[1]/td
    Table Row Should Contain                    xpath=//table[@id="datatable_list"]/tbody/tr[1]/td  1  ${search_term}

Verify Search Result Completed by All Filters
    [Arguments]     ${search_term}
    IF  "${search_term.Username}" != "${EMPTY}"
        Table Row Should Contain                xpath=//table[@id="datatable_list"]/tbody/tr[1]/td[2]  1  ${search_term.Username}
    END
    IF  "${search_term.FullName}" != "${EMPTY}"
        Table Row Should Contain                xpath=//table[@id="datatable_list"]/tbody/tr[1]/td[3]  1  ${search_term.FullName}
    END
    IF  "${search_term.Role}" != "${EMPTY}"
        Table Row Should Contain                xpath=//table[@id="datatable_list"]/tbody/tr[1]/td[4]  1  ${search_term.Role}
    END
    IF  "${search_term.Status}" != "${EMPTY}"
        Table Row Should Contain                xpath=//table[@id="datatable_list"]/tbody/tr[1]/td[5]  1  ${search_term.Status}
    END
    IF  "${search_term.FromDate}" != "${EMPTY}"
        Verify Search Result Completed by Date  ${search_term}
    END

Verify Search Result Completed by Date
    [Arguments]     ${search_term}
    Wait Until Element Is Visible           xpath=//*[@id="datatable_list"]/tbody/tr/td[6]
    ${getDate} =    Get Text                xpath=//*[@id="datatable_list"]/tbody/tr/td[6]
    ${getDate} =    Convert Date            ${getDate}  date_format=%Y-%m-%d %H:%M:%S  result_format=datetime
    ${fromDate} =    Convert Date           ${search_term.FromDate}  date_format=%Y-%m-%d  result_format=datetime
    ${toDate} =    Convert Date             ${search_term.ToDate}  date_format=%Y-%m-%d  result_format=datetime
    ${datePeriod} =  Evaluate               '${fromDate}' <= '${getDate}' <= '${toDate}'
    Should Be True  ${datePeriod}
    Table Row Should Contain                xpath=//table[@id="datatable_list"]/tbody/tr/td[6]  1  ${getDate}

Verify Search Not Found
    Table Row Should Contain                xpath=//table[@id="datatable_list"]/tbody/tr/td  1  No matching records found

Verify Delete Confirmation Popup Displayed
    Wait Until Element Is Visible           ${USER_LIST_HEADER_POPUP_DELETE_LABEL}
    Element Should Contain                  ${USER_LIST_HEADER_POPUP_DELETE_LABEL}  Are you sure you want to delete this?

Verify User Deleted Successfully
    Wait Until Page Contains                Data has been saved successfully

Verify Reset Confirmation Popup Displayed
    Wait Until Element Is Visible           ${USER_LIST_HEADER_POPUP_RESET_PW_LABEL}
    Element Should Contain                  ${USER_LIST_HEADER_POPUP_RESET_PW_LABEL}  Reset Password

Verify Clear Search Term Completed
    Element Text Should Be                  ${USER_LIST_USER_NAME_TEXTBOX}  ${EMPTY}
    Element Text Should Be                  ${USER_LIST_FULL_NAME_TEXTBOX}  ${EMPTY}

###################################################################
######                  Actions - Search Form                 #####
###################################################################
Click "Add New User" Link
    Click Link                                ${USER_LIST_ADD_NEW_USER_LINK}

Search for Users
    [Arguments]     ${search_term}
    IF  "${search_term.Username}" != "${EMPTY}"
        Enter "Username" Field                ${search_term.Username}
    END
    IF  "${search_term.FullName}" != "${EMPTY}"
        Enter "Full Name" Field               ${search_term.FullName}
    END
    IF  "${search_term.Role}" != "${EMPTY}"
        Select "Role" In Dropdown-list        ${search_term.Role}
    END
    IF  "${search_term.Status}" != "${EMPTY}"
        Select "Status" In Dropdown-list      ${search_term.Status}
    END

Enter "Username" Field
    [Arguments]     ${username}
    Input Text                              ${USER_LIST_USER_NAME_TEXTBOX}  ${username}

Enter "Full Name" Field
    [Arguments]     ${fullname}
    Input Text                              ${USER_LIST_FULL_NAME_TEXTBOX}  ${fullname}

Select "Role" In Dropdown-list
    [Arguments]     ${role}
    Select From List By Label               ${USER_LIST_ROLE_DROPDOWN}      ${role}

Select "Status" In Dropdown-list
    [Arguments]     ${status}
    Select From List By Label               ${USER_LIST_STATUS_DROPDOWN}    ${status}

Click "From Date" Field
    Wait Until Page Contains Element        ${USER_LIST_FROM_DATE_TEXTBOX}
    Click Element                           ${USER_LIST_FROM_DATE_TEXTBOX}

Click "Date Title" In Calendar
    Wait Until Page Contains Element        ${USER_LIST_DATE_PICKER_TITLE}
    Click Element                           ${USER_LIST_DATE_PICKER_TITLE}

Click "To Date" Field
    Wait Until Page Contains Element        ${USER_LIST_TO_DATE_TEXTBOX}
    Click Element                           ${USER_LIST_TO_DATE_TEXTBOX}

Click "Left" Arrow In Calendar
    Click Element                           ${USER_LIST_DATE_PICKER_LEFT_ARROW}

Click "Right" Arrow In Calendar
    Click Element                           ${USER_LIST_DATE_PICKER_RIGHT_ARROW}

Select "Year" In Calendar
    [Arguments]     ${year}
    Click Element   xpath=//div[@class="datepicker--years datepicker--body active"]//div[@data-year="${year}"]

Select "Month" In Calendar
    [Arguments]     ${month}
    Click Element   xpath=//div[@class="datepicker--months datepicker--body active"]//div[@data-month="${month}"]

Select "Date" In Calendar
    [Arguments]     ${date}
    Click Element   xpath=//div[@class="datepicker--days datepicker--body active"]//div[@data-date="${date.Date}" and @data-month="${date.Month}" and @data-year="${date.Year}"]

Click "Reset" Button
    Click Button                            ${USER_LIST_RESET_BUTTON}

Click "Search" Button
    Click Button                            ${USER_LIST_SEARCH_BUTTON}

###################################################################
######          Actions - Edit/Remove/Reset Password          #####
###################################################################
Click "Edit" Icon in Table Row
    Click Element                           ${USER_LIST_EDIT_ICON}

Click "Remove" Icon in Table Row
    Click Element                           ${USER_LIST_REMOVE_ICON}

Click "Reset Password" Icon in Table Row
    Click Element                           ${USER_LIST_RESET_PASSWORD_ICON}

Click "Confirm" Button to Delete User
    Click Element                           ${USER_LIST_CONFIRM_DELETE_BUTTON}

Click "Cancel" Button to Not Delete User
    Click Element                           ${USER_LIST_CANCEL_DELETE_BUTTON}

###################################################################
######             Logics - Select Year/Month/Date            #####
###################################################################
Datepicker Moving Controller
    [Arguments]  ${selectDate}
    ${currentDate} =    Get Current Date    result_format=datetime
    ${convertDate} =    Convert Date  ${selectDate}  date_format=%Y-%m-%d  result_format=datetime
    ${date} =           Convert To Integer  ${convertDate.day}
    ${month} =          Evaluate  ${convertDate.month}-1
    ${year} =           Convert To Integer  ${convertDate.year}
    ${year_diff} =      Evaluate  ${year}-${currentDate.year}
    ${move} =           Evaluate  math.floor(${year_diff}/10)
    &{date_info}        Create Dictionary  Year=  Month=  Date=
    ${date_info.Year} =   Set Variable     ${year}
    ${date_info.Month} =  Set Variable     ${month}
    ${date_info.Date} =   Set Variable     ${date}

    ${shiftForward} =  Set Variable If
    ...   ${move}==0  2  # No need to move
    ...   ${move}>0   1  # Move forward
    ...   ${move}<0   0  # Move backward

    # Count of hits to move forward/backward
    ${move} =  Set Variable If  
    ...   ${move}>0   ${move}
    ...   ${move}<0   ${move}*-1
    ...   ${move}==0  0

    IF  ${shiftForward} != 2
        FOR     ${var}  IN RANGE    ${move}
            Run Keyword If  ${shiftForward} == 0  Click "Left" Arrow In Calendar
            Run Keyword If  ${shiftForward} == 1  Click "Right" Arrow In Calendar
        END
    END
    
    [Return]  ${date_info}