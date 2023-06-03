*** Settings ***
Resource        ${EXECDIR}/Data/InputData.robot
Resource        ${EXECDIR}/Resources/Common/CommonApp.robot
Resource        ${EXECDIR}/Resources/Kid-MyWallet/KidMyWalletApp.robot
Resource        ${EXECDIR}/Resources/DataManager/DataManager.robot

Suite Setup     Run Keywords    Begin Web Test
...             AND             Login with Valid Credentials  ${CREDENTIALS}
...             AND             Navigate to "User Management" Page
Test Setup      Add New User    ${ADD_NEW_USER_INFO}
Test Teardown   Clear Search Term
Suite Teardown  End Web Test

#   Copy/Paste the comand below into terminal to run the script
#   robot -d Results Tests/TC_DeleteUser.robot
#   robot -d Results -i 1003 Tests/TC_DeleteUser.robot

*** Test Cases ***
Should be able to delete user
    [Tags]      1001
    KidMyWalletApp.Search for Users by Username     ${ADD_NEW_USER_INFO.Username}
    KidMyWalletApp.Select User from Search Result to Remove
    KidMyWalletApp.Remove the Selected User

Should be able to cancel to delete user
    [Tags]      1002
    KidMyWalletApp.Search for Users by Username     ${ADD_NEW_USER_INFO.Username}
    KidMyWalletApp.Select User from Search Result to Remove
    KidMyWalletApp.Cancel to Remove the Selected User