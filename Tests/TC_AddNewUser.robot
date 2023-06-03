*** Settings ***
Documentation   Using DataDriver Lib with Excel to Do Data Driven Testing
Library         DataDriver      ${EXECDIR}/Data/External Files/InputData_AddNewUser.xlsx       sheet_name=Sheet1
Resource        ${EXECDIR}/Data/InputData.robot
Resource        ${EXECDIR}/Resources/Common/CommonApp.robot
Resource        ${EXECDIR}/Resources/Kid-MyWallet/KidMyWalletApp.robot
Resource        ${EXECDIR}/Resources/DataManager/DataManager.robot

Suite Setup     Run Keywords    Begin Web Test    
...             AND             Login with Valid Credentials  ${CREDENTIALS}
Test Setup      Navigate to "User Management" Page
Test Template   Test Multiple Add New User Scenarios
Test Teardown   Back to "Main" Page
Suite Teardown  End Web Test

#   Copy/Paste the comand below into terminal to run the script
#   robot -d Results Tests/TC_AddNewUser.robot

*** Test Cases ***
${tc_no} ${tc_name}

*** Keywords ***
Test Multiple Add New User Scenarios
    [Arguments]     ${username}  ${password}  ${fullname}  ${role}  ${mobile}  ${email}  ${status}  ${expect_msg}  ${case_type}
    KidMyWalletApp.Add New User Many Scenarios  ${username}  ${password}  ${fullname}  ${role}  ${mobile}  ${email}  ${status}  ${expect_msg}  ${case_type}