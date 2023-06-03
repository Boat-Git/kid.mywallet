*** Settings ***
Documentation   Using Custom Lib from Python to Do Data Driven Testing by using For Loop
Resource        ${EXECDIR}/Data/InputData.robot
Resource        ${EXECDIR}/Resources/Common/CommonApp.robot
Resource        ${EXECDIR}/Resources/Kid-MyWallet/KidMyWalletApp.robot
Resource        ${EXECDIR}/Resources/DataManager/DataManager.robot

Suite Setup     Run Keywords    Begin Web Test    
...             AND             Login with Valid Credentials  ${CREDENTIALS}
...             AND             Navigate to "User Management" Page
Suite Teardown  End Web Test

#   Copy/Paste the comand below into terminal to run the script
#   robot -d Results Tests/TC_EditUser.robot
#   robot -d Results -i 1001 Tests/TC_EditUser.robot

*** Test Cases ***
Should be able to edit user info with many scenarios
    [Tags]      1001
    ${EditScenarios} =  DataManager.Get CSV Data  ${EDIT_USER_CSV_PATH}
    KidMyWalletApp.Edit User with Many Scenarios  ${EditScenarios}