*** Settings ***
Documentation    Global documentation
Resource         ./resources/keywords.robot
Library          SeleniumLibrary
Test Setup       Begin Web Test
Test Teardown    End Web Test

*** Variables ***
${BROWSER} =		firefox
${URL} =    		http://rental19.infotiv.net/
${SEARCH_TERM} =    	""
${EMAIL} =     		last@chance.com
${PASSWORD} =  		password
${BAD_EMAIL} =		wrong@as.can.be
${BAD_PASSWORD} =	ClearlyWrong
${FNAME} =      AnonymouzIz
${LNAME} =      C0wardz
${PHONE} =      5555123456

*** Keywords ***
# Testet är designat för att gå igenom men egentligen så ska det vara ett fail
# då source-filer saknas på siten. Följ anvisningarna i keyword;
# 'Then the user expects to access documentation & Source files' för att köra 
# Testet 'på riktigt' /Daniel

Browse Documentation
        [Arguments]	${anchor}
	Click Link	${anchor}

User Is Already Registered And Logged In	
	Go To Web Page
	Verify Page Loaded
	Enter Email	${EMAIL}
	Enter Password 	${PASSWORD}
	Click Button Login
	Page Should Contain	You are signed in as ${FNAME}
	
User Clicks The About-Link
	Click Element	xpath://a[@id="about"]
	Wait Until Page Contains	Homepage version:

User Expects To Access Documentation & Source Files	
	Click Element	xpath://a[@id="linkButton"][@href="/webpage/documentation/index.html"]	
	Switch Window	url:http://rental19.infotiv.net/webpage/html/gui/about.php
	Switch Window	locator=new
	Set Window Position	100	100
	Set Window Size		900	500
	Page Should Contain	To simply view the homepage
	Browse Documentation     xpath://a[@href="#line2"]
	Browse Documentation     xpath://a[@href="#line3"]
	Browse Documentation     xpath://a[@href="#line4"]
	Browse Documentation     xpath://a[@href="#line5"]
	Browse Documentation     xpath://a[@href="#line1"]
	Browse Documentation     xpath://html/body/div/div/div/div[2]/section[2]/div[1]/div/h2/a
	Switch Window  url:http://rental19.infotiv.net/webpage/html/gui/about.php
	Browse Documentation	 xpath://a[@id="linkButton"][@href="https://projekt.infotiv.se/projects/itd-car-rental/repository"]
	Switch Window	locator=new
	Set Window Size		900	500
	Set Window Position	150	150
	# Change this to 'page should contain' to make the test fail as it should
	Page Should Not Contain		//Script that inserts todays date in the start date and end date
	# Remove the following line if you intend to run the test properly
	Wait Until Page Contains	Unable to connect     timeout=30
	Close Window
	Switch Window	url:http://rental19.infotiv.net/webpage/documentation/index.html
	Close Window	



*** Test Cases ***
Load URL
    [Documentation]  Laddar sidan
    [Tags]  Laddar sidan
    Go To Web Page
    Verify Page Loaded

Log in with the wrong credentials
	[Documentation]		User logging in with the wrong credentials
	[Tags]			negative
	Go To Web Page
	Verify Page Loaded
	Enter Email		${BAD_EMAIL}
	Enter Password  	${BAD_PASSWORD}
	Click Button Login
	Verify Login Failed
	
Test MyPage Gherkin
	[Documentation]		Given that user is registered, the user logs in and clicks the My Page button expecting to see their personal page.
	[Tags]			gherkin
	Given That User Already Registered
	When User Logs In And Clicks My Page
	Then The User Expects To See Page

Input No Value
	[Documentation]		Submit field with no value
	[Tags]			Submit_no_value
	Go To Web Page
	Verify Page Loaded
	Click Button Login
    	Verify Login Page Warning

Reset button on Date Selection
	[Documentation]		Reset button on date selection should go back to a correct date after entering 0 in the date.
	[Tags]			reset_button
	Go To Web Page
	Verify Page Loaded
    	Delete Date
    	Click reset button and go to the next page

Long test
    [Documentation]	Extended test 
    [Tags]  		try_buy
    Go To Web Page
    Verify Page Loaded
    Enter Email		${EMAIL}
    Enter Password  	${PASSWORD}
    Click Button Login
    Click Link And Verify Page		about.php	about
    Click Element And Verify Page	index.php	logo	
    Click Button And Verify Page	myPage.php	mypage
    Click Selected Button    		show
    Check Page Contains			Order
    Click Selected Button     		hide
    Click Element And Verify Page	index.php	logo	
#    Set Selenium Speed      		1 seconds		
    Book Car
    Log Out

VG_test
	[Documentation]		Beteende och acceptansdrivet funktionellt test av website. Användaren loggar in, klickar på 'About' och läser dokumentation och källkod. 
	[Tags]			VG_test
	Given User Is Already Registered And Logged In
	When User Clicks The About-Link
	Then User Expects To Access Documentation & Source Files	
	

