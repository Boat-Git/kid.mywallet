*** Settings ***
Resource        ${EXECDIR}/Data/InputData.robot
Resource        ${EXECDIR}/Resources/Common/CommonApp.robot
Resource        ${EXECDIR}/Resources/Kid-MyWallet/KidMyWalletApp.robot
Resource        ${EXECDIR}/Resources/DataManager/DataManager.robot

Suite Setup     Run Keywords    Begin Web Test    
...             AND             Login with Valid Credentials  ${CREDENTIALS}
...             AND             Navigate to "User Management" Page
Test Teardown   Clear Search Term
Suite Teardown  End Web Test

#   Copy/Paste the comand below into terminal to run the script
#   robot -d Results Tests/TC_SearchUser.robot
#   robot -d Results -i 1002 Tests/TC_SearchUser.robot

*** Test Cases ***

Should be able to search by username
    [Tags]      1001
    KidMyWalletApp.Search for Users by Username     ${SEARCH_TERM.Username}

# Should be able to search by full name
#     [Tags]      1002
#     KidMyWalletApp.Search for Users by Full Name    ${SEARCH_TERM.FullName}

Should be able to search by role
    [Tags]      1003
    KidMyWalletApp.Search for Users by Role  ${SEARCH_TERM.Role}

Should be able to search by status
    [Tags]      1004
    KidMyWalletApp.Search for Users by Status  ${SEARCH_TERM.Status}

Should be able to search by date
    [Tags]      1005
    KidMyWalletApp.Search for Users by Date  ${SEARCH_TERM}

# Should be able to search by all filters
#     [Tags]      1006
#     KidMyWalletApp.Search for Users by All Filters  ${SEARCH_TERM}

Should be able to see no matching records found
    [Tags]      1007
    KidMyWalletApp.Search for Users by not exist username  ${SEARCH_NO_EXIST_USER}

Should be able to clear search results
    [Tags]      1008
    KidMyWalletApp.Search for Users by Username     ${SEARCH_TERM.Username}
    KidMyWalletApp.Clear Search Term