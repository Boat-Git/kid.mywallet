*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${TOPNAV_PROFILE_ICON} =                xpath=//img[@class="b-r-10"]
${TOPNAV_MY_ACCOUNT_LIST} =             xpath=//li[@class="goto"]
${TOPNAV_LOGOUT_LIST} =                 xpath=//li[@onclick="logout()"]

*** Keywords ***

###################################################################
######                        Actions                         #####
###################################################################
Click "Profile" Setting
    Click Element                       ${TOPNAV_PROFILE_ICON}

Click "Log out" Link
    Click Element                       ${TOPNAV_LOGOUT_LIST}