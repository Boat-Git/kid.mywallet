*** Settings ***
Library         String
Resource        ${EXECDIR}/Resources/Kid-MyWallet/PO/Landing.robot
Resource        ${EXECDIR}/Resources/Kid-MyWallet/PO/Main.robot
Resource        ${EXECDIR}/Resources/Kid-MyWallet/PO/TopNav.robot
Resource        ${EXECDIR}/Resources/Kid-MyWallet/PO/MainMenu.robot
Resource        ${EXECDIR}/Resources/Kid-MyWallet/PO/UserManagement/UserList.robot
Resource        ${EXECDIR}/Resources/Kid-MyWallet/PO/UserManagement/AddNewUser.robot
Resource        ${EXECDIR}/Resources/Kid-MyWallet/PO/UserManagement/EditUser.robot

*** Keywords ***
###################################################################
######                   Navigation                           #####  
###################################################################
Navigate to "Landing" Page
    Landing.Navigate To
    Landing.Verify Page Loaded

Navigate to "User Management" Page
    MainMenu.Click "User Management" Link
    MainMenu.Click "User List" Link
    UserList.Verify Page Loaded

Back to "Main" Page
    MainMenu.Click "Welcome" Icon
    Main.Verify Page Loaded

###################################################################
######                   Login Function                       #####  
###################################################################
Login with Valid Credentials
    [Arguments]     ${credentials}
    Navigate to "Landing" Page
    Attempt Login  ${credentials}
    Main.Verify Page Loaded

Test Multiple Login Scenarios
    [Arguments]     ${credentials}
    Navigate to "Landing" Page
    Attempt Login   ${credentials}
    Verify Login Results  ${credentials}

Attempt Login
    [Arguments]     ${credentials}
    Landing.Enter Credentials   ${credentials}
    Landing.Click "Login" Button
    Sleep  0.5s

Verify Login Results
    [Arguments]     ${credentials}
    IF  "${credentials.CaseType}" == "Positive"
        Main.Verify Page Loaded
    ELSE IF  "${credentials.CaseType}" == "Negative"
        Landing.Verify Expected Error  ${credentials}
    END

Log Out
    TopNav.Click "Profile" Setting
    TopNav.Click "Log out" Link
    Landing.Verify Page Loaded

###################################################################
######         User Management - Search Function              #####
###################################################################
Search for Users by Username
    [Arguments]     ${username}
    UserList.Enter "Username" Field  ${username}
    UserList.Click "Search" Button
    UserList.Verify Search Result Completed  ${username}

Search for Users by Full Name
    [Arguments]     ${fullname}
    UserList.Enter "Full Name" Field  ${fullname}
    UserList.Click "Search" Button
    UserList.Verify Search Result Completed  ${fullname}

Search for Users by Role
    [Arguments]     ${role}
    UserList.Select "Role" In Dropdown-list  ${role}
    UserList.Click "Search" Button
    UserList.Verify Search Result Completed  ${role}

Search for Users by Status
    [Arguments]     ${status}
    UserList.Select "Status" In Dropdown-list  ${status}
    UserList.Click "Search" Button
    UserList.Verify Search Result Completed  ${status}

Search for Users by not exist username
    [Arguments]     ${username}
    UserList.Enter "Username" Field  ${username}
    UserList.Click "Search" Button
    UserList.Verify Search Not Found

Search for Users by Date
    [Arguments]     ${date}
    IF  "${date.FromDate}" != "${EMPTY}"  
        Select "From Date" to Search  ${date}
    END
    IF  "${date.ToDate}" != "${EMPTY}"    
        Select "To Date" to Search    ${date}
    END
    Submit "Search" Term  ${date}
    Sleep  0.5s

Select "From Date" to Search
    [Arguments]     ${date}
    UserList.Click "From Date" Field
    UserList.Click "Date Title" In Calendar
    UserList.Click "Date Title" In Calendar
    ${date_info} =  UserList.Datepicker Moving Controller  ${date.FromDate}
    UserList.Select "Year" In Calendar   ${date_info.Year}
    UserList.Select "Month" In Calendar  ${date_info.Month}
    UserList.Select "Date" In Calendar   ${date_info}

Select "To Date" to Search
    [Arguments]     ${date}
    UserList.Click "To Date" Field
    UserList.Click "Date Title" In Calendar
    UserList.Click "Date Title" In Calendar
    ${date_info} =  UserList.Datepicker Moving Controller  ${date.ToDate}
    UserList.Select "Year" In Calendar   ${date_info.Year}
    UserList.Select "Month" In Calendar  ${date_info.Month}
    UserList.Select "Date" In Calendar   ${date_info}

Search for Users by All Filters
    [Arguments]     ${search_term}
    UserList.Search for Users  ${search_term}
    Search for Users by Date  ${search_term}
    #UserList.Click "Search" Button
    ${passed} =  Run Keyword And Return Status         UserList.Verify Search Result Completed by All Filters  ${search_term}
    IF  ${passed} == False
        UserList.Verify Search Not Found
    END
    Sleep  0.5s

Submit "Search" Term
    [Arguments]     ${search_term}
    UserList.Click "Search" Button
    ${passed} =  Run Keyword And Return Status         UserList.Verify Search Result Completed by Date  ${search_term}
    IF  ${passed} == False
        UserList.Verify Search Not Found
    END

Clear Search Term
    UserList.Click "Reset" Button
    UserList.Verify Clear Search Term Completed

###################################################################
######           User Management - Add Function               #####  
###################################################################
Add New User
    [Arguments]     ${user_info}
    #random username to prevent duplicate user
    ${random_number} =  Generate Random String  3   [NUMBERS]
    ${user_info.Username} =  Set Variable   Test_RF
    ${user_info.Username} =  Catenate  SEPARATOR=_  ${user_info.Username}  ${random_number}

    UserList.Click "Add New User" Link
    AddNewUser.Verify Page Loaded
    AddNewUser.Input User Information  ${user_info.Username}  ${user_info.Password}  ${user_info.FullName}
    ...                                ${user_info.Role}      ${user_info.Mobile}    ${user_info.Email}     ${user_info.Status}
    AddNewUser.Click "Save" Button
    EditUser.Verify Page Loaded
    EditUser.Verify User Updated Successfully  ${user_info.Username}  ${user_info.FullName}  ${user_info.Role}  
    ...                                        ${user_info.Mobile}    ${user_info.Email}     ${user_info.Status}
    EditUser.Click "Close" Button
    UserList.Verify Page Loaded

Add New User Many Scenarios
    [Arguments]     ${username}  ${password}  ${fullname}  ${role}  ${mobile}  ${email}  ${status}  ${expect_msg}  ${case_type}
    Attempt Add New User  ${username}  ${password}  ${fullname}  ${role}  ${mobile}  ${email}  ${status}
    Verify Added User Results  ${username}  ${password}  ${fullname}  ${role}  ${mobile}  ${email}  ${status}  ${expect_msg}  ${case_type}

Attempt Add New User
    [Arguments]     ${username}  ${password}  ${fullname}  ${role}  ${mobile}  ${email}  ${status}
    UserList.Click "Add New User" Link
    AddNewUser.Verify Page Loaded
    AddNewUser.Input User Information  ${username}  ${password}  ${fullname}  ${role}  ${mobile}  ${email}  ${status}  
    AddNewUser.Click "Save" Button

Verify Added User Results
    [Arguments]     ${username}  ${password}  ${fullname}  ${role}  ${mobile}  ${email}  ${status}  ${expect_msg}  ${case_type}
    IF  "${case_type}" == "Positive"
        EditUser.Verify Page Loaded
        EditUser.Verify User Updated Successfully  ${username}  ${fullname}  ${role}  ${mobile}  ${email}  ${status}
        EditUser.Click "Close" Button
        UserList.Verify Page Loaded
    ELSE
        AddNewUser.Verify Expected Results  ${username}  ${fullname}  ${role}  ${expect_msg}
        AddNewUser.Click "Close" Button
        UserList.Verify Page Loaded
    END

###################################################################
######           User Management - Edit Function              #####  
###################################################################
Select User from Search Result to Edit
    UserList.Click "Edit" Icon in Table Row
    EditUser.Verify Page Loaded

Attempt Edit User Information
    [Arguments]     ${EditScenario}
    EditUser.Update User Information  ${EditScenario}
    EditUser.Click "Save" Button

Verify Edited User Results
    [Arguments]     ${EditScenario}
    #EditUser.Verify Expected Results  ${EditScenario}
    IF  "${EditScenario[9]}" == "Positive"
        Wait Until Page Contains        ${EditScenario[8]}
        EditUser.Verify User Updated Successfully  ${EditScenario[2]}  ${EditScenario[3]}  ${EditScenario[4]}  ${EditScenario[5]}  ${EditScenario[6]}  ${EditScenario[7]}
    ELSE  "${EditScenario[9]}" == "Negative"
        EditUser.Verify Required Field    ${EditScenario[2]}  ${EditScenario[3]}  ${EditScenario[4]}
    END
    EditUser.Click "Close" Button
    UserList.Verify Page Loaded

Edit User with Many Scenarios
    [Arguments]     ${EditManyScenarios}
    FOR  ${EditScenario}  IN  @{EditManyScenarios}
        Add New User    ${ADD_NEW_USER_INFO}
        Search for Users by Username        ${ADD_NEW_USER_INFO.Username}
        Select User from Search Result to Edit
        Attempt Edit User Information       ${EditScenario}
        Verify Edited User Results          ${EditScenario}
    END

###################################################################
######            User Management - Delete Function           #####  
###################################################################
Select User from Search Result to Remove
    UserList.Click "Remove" Icon in Table Row
    UserList.Verify Delete Confirmation Popup Displayed

Remove the Selected User
    UserList.Click "Confirm" Button to Delete User

Cancel to Remove the Selected User
    UserList.Click "Cancel" Button to Not Delete User

Remove Added User
    [Arguments]  ${username}  ${case_type}
    IF  "${case_type}" == "Positive"
        Search for Users by Username  ${username}
        Select User from Search Result to Remove
        Remove the Selected User
    END

Select User from Search Result to Reset their Password
    UserList.Click "Reset Password" Icon in Table Row
    UserList.Verify Reset Confirmation Popup Displayed