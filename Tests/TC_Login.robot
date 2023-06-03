*** Settings ***
Documentation   Using Dictionary variable to do data driven testing
Resource        ${EXECDIR}/Data/InputData.robot
Resource        ${EXECDIR}/Resources/Common/CommonApp.robot
Resource        ${EXECDIR}/Resources/Kid-MyWallet/KidMyWalletApp.robot
Resource        ${EXECDIR}/Resources/DataManager/DataManager.robot

Test Setup      CommonApp.Begin Web Test
Test Teardown   CommonApp.End Web Test

#   Copy/Paste the comand below into terminal to run the script
#   robot -d Results Tests/TC_Login.robot
#   robot -d Results -i Multiple_Login Tests/TC_Login.robot

*** Test Cases ***

Should be able to access "Login" page
    KidMyWalletApp.Navigate to "Landing" Page

Should be able to login with valid credentials
    [Tags]      Login
    KidMyWalletApp.Navigate to "Landing" Page
    KidMyWalletApp.Login with Valid Credentials     ${CREDENTIALS}

Should be able to login with many scenarios
    [Template]  Test Multiple Login Scenarios
    [Tags]      Multiple_Login
    ${VALID_CREDENTIALS}
    ${UNREGISTERED_USER}
    ${INVALID_PASSWORD_USER}
    ${BLANK_CREDENTIALS_USER}

Should be able to logout
    [Tags]      Logout
    KidMyWalletApp.Navigate to "Landing" Page
    KidMyWalletApp.Login with Valid Credentials     ${CREDENTIALS}
    KidMyWalletApp.Log Out

# Should be able to login with many credentials
#     [Tags]              Login_2
#     ${LoginScenarios} =  DataManager.Get CSV Data   ${CREDENTIALS_CSV_PATH}
#     KidMyWalletApp.Login with Many Credentials      ${LoginScenarios}