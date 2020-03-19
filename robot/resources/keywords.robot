*** Keywords ***
Begin Web Test
      Open Browser	about:blank	${BROWSER}
      Maximize Browser Window
      Go To Web Page
      Verify Page Loaded

End Web Test
    Close Browser

Go To Web Page
   Go To	${URL}

Verify Page Loaded
    ${link_text} =	Get Text	id:questionText
    Should Be Equal	${link_text}	When do you want to make your trip?

Click Button Login
	Click Button	xpath://button[@id="login"]

Enter Email
	[Arguments]	${email}
	Input Text	xpath://input[@id="email"]	${email}

ENTER PASSWORD
	[Arguments]	${password}
	INPUT Text	xpath://input[@id="password"]	${password}
	 				
Verify fail
	Wait Until Page Contains Element	xpath://label[@id="signInError"]
	Should be equal  Get Text  xpath://label[@id="signInError"] 		

Click Button Mypage
	Click Button	xpath://button[@id="mypage"]
	${title_value} =	    Get Title
    	Should Be Equal	    ${title_value}	Mypage	

Verify Login Page Loaded
       Wait Until Page Contains Element 	xpath://label[@id="welcomePhrase"]

Verify Login Failed
       Wait Until Page Contains Element 	xpath://label[@id="signInError"]
       ${status_message} = 	Get Text	xpath://label[@id="signInError"]
       Should Be Equal	 ${status_message}	Wrong e-mail or password 

Given That User Already Registered
	Go To Web Page	
	Verify Page Loaded	

When User Logs In And Clicks My Page
	Enter Email  ${EMAIL}
	Enter Password  ${PASSWORD}
	Click Button Login 
	Verify Login Page Loaded	

Then The User Expects To See Page
	Click Button MyPage


Verify Login Page Warning
    Element Attribute Value Should Be     xpath://*[@id="email"]  required  true

Delete Date
    Input Text	    xpath://input[@id="start"]	0000-00-00
    Click Button    xpath://button[@id="continue"]
    Element Attribute Value Should Be     xpath://*[@id="start"]  required  true

Click Reset button and go to the next page
    Click Button    xpath://button[@id="reset"]
    Click Button    xpath://button[@id="continue"]
    Wait Until Page Contains Element	xpath://h1[@id="questionText"]
    ${link_text} =	Get Text	id:questionText
    Should Be Equal	${link_text}	What would you like to drive?

Click Link About
	Click Link			xpath://a[@id="about"]
	Location Should Contain		about.php

Click Logo
	Click Element	xpath://div[@id="logo"]
	Location Should Contain		index.php

Click Element And Verify Page
	[Arguments]	${url_should_contain}		${element_id}
	Click Element	xpath://div[@id="${element_id}"]
	Location Should Contain		${url_should_contain}

Click Link And Verify Page
	[Arguments]	${url_should_contain}		${link_id}
	Click Link	xpath://a[@id="${link_id}"]
	Location Should Contain		${url_should_contain}

Click Button And Verify Page
	[Arguments]	${url_should_contain}		${button_id}
	Click Button	xpath://button[@id="${button_id}"]
	Location Should Contain		${url_should_contain}

Click Documentation
       Click Link	xpath://a[@id="linkButton"]
       Switch Window	locator=NEW
       Location Should Contain		documentation
       Close Window

Click Selected Button 
	[Arguments]	${button_id}
	Click Button	xpath://button[@id="${button_id}"]

Check Page Contains
	[Arguments]	${text}
	Wait Until Page Contains	Order
	Page Should Contain		${text}

Check Page Not Contains
	[Arguments]	${text}
	Page Should Not Contain		${text}

Book Car
	Input Text	xpath://input[@id="start"]	2020-03-24
	Input Text	xpath://input[@id="end"]	2020-04-24
	Click Selected Button				continue
	Wait Until Page Contains Element  xpath://input[@id="bookQ7pass5"]  timeout=12
	Click Element	xpath://input[@id="bookQ7pass5"]
	Wait Until Page Contains Element  xpath://input[@id="cardNum"]	timeout=12
	Input Text	xpath://input[@id="cardNum"]	0123456789012345	
	Input Text	xpath://input[@id="fullName"]	Anonymous Coward
	Click Element	xpath://*[@id="month3"]
	Click Element	xpath://*[@id="month2024"]
	Input Text	xpath://input[@id="cvc"]	123
	Click Button	xpath://button[@id="confirm"]
	Page Should Contain	is now ready for pickup
	Click Button	xpath://button[@id="mypage"]
	Page Should Contain	My bookings
	Click Button		xpath://button[@id="unBook1"]
	Handle Alert
Log Out
	Click Button	xpath://button[@id="logout"]
