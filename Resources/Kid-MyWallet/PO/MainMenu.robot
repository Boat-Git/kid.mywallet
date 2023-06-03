*** Settings ***
Library         SeleniumLibrary

*** Variables ***
${MAINMENU_LOGO_IMG} =                  xpath=//*[@id="pageWrapper"]/div[2]/header/div[1]/a/img
${MAINMENU_MEMBER_MGMNT_LINK} =         xpath=//a[span[text()="Member Management"]]
${MAINMENU_MEMBER_LIST_LINK} =          xpath=//a[@data-attr="MEMB_LS"]
${MAINMENU_MEMBER_GROUP_LINK} =         xpath=//a[@data-attr="MEMB_GRP"]
${MAINMENU_USER_MGMNT_LINK} =           xpath=//a[span[text()="User Management"]]
${MAINMENU_USER_LIST_LINK} =            xpath=//a[@data-attr="USER_LS"]
${MAINMENU_ROLE_PERMISSION_LINK} =      xpath=//a[@data-attr="USER_ROLE"]
${MAINMENU_EVENT_MGMNT_LINK} =          xpath=//a[span[text()="Event Management"]]
${MAINMENU_ANNOUNCE_MGMNT_LINK} =       xpath=//a[span[text()="Announce Management"]]
${MAINMENU_NOTIFICATION_MGMNT_LINK} =   xpath=//a[span[text()="Notification Management"]]
${MAINMENU_MUSEUM_INFO_LINK} =          xpath=//a[span[text()="Museum Infomation"]]
${MAINMENU_REPORT_LINK} =               xpath=//a[span[text()="Report"]]
${MAINMENU_DIGITAL_CARD_SUM_LINK} =     xpath=//a[@data-attr="RP_PDL"]
${MAINMENU_DIGITAL_CARD_STAT_LINK} =    xpath=//a[@data-attr="RP_PST"]
${MAINMENU_USER_PASS_LOGS_LINK} =       xpath=//a[@data-attr="RP_UAL"]

*** Keywords ***

###################################################################
######                        Actions                         #####
###################################################################
Click "Welcome" Icon
    Click Element                       ${MAINMENU_LOGO_IMG}

Click "Member Management" Link
    Click Element                       ${MAINMENU_MEMBER_MGMNT_LINK}

Click "User Management" Link
    Click Element                       ${MAINMENU_USER_MGMNT_LINK}

Click "User List" Link
    Click Element                       ${MAINMENU_USER_LIST_LINK}

Click "Event Management" Link
    Click Element                       ${MAINMENU_EVENT_MGMNT_LINK}

Click "Announce Management" Link
    Click Element                       ${MAINMENU_ANNOUNCE_MGMNT_LINK}

Click "Notification Management" Link
    Click Element                       ${MAINMENU_NOTIFICATION_MGMNT_LINK}

Click "Museum Information" Link
    Click Element                       ${MAINMENU_MUSEUM_INFO_LINK}

Click "Report" Link
    Click Element                       ${MAINMENU_REPORT_LINK}