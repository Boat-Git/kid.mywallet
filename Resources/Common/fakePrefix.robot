*** Settings ***
Library  SeleniumLibrary
Library  FakerLibrary
Library  BuiltIn

*** Keywords ***
Initialize test data
    ${ran_num} =  FakerLibrary.Random Number  digits=4
    ${r} =  FakerLibrary.Word
    ${group_name} =  Set Variable  ${r}${ran_num}
    [Return]  ${group_name}