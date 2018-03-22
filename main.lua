-----------------------------------------------------------------------------------------
-- Title: NumericTextFields
-- Name: Dante Beltran		
-- Course: ICS2O/3C
-- This program displays a math question and asks the user to answer in a numeric textfield
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- sets the backround colour
display.setDefault("background", 10/255, 20/255, 50/255)

-------------------------------------------------------------------------------------
-- LOCAL VARIABLES
-------------------------------------------------------------------------------------

-- create local variables
local questionObject
local correctObject
local numericFeild
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local operator
local counter = 0
local counterText

-------------------------------------------------------------------------------------
-- LOCAL FUNCTIONS
-------------------------------------------------------------------------------------

local function AskQuestion()

	operator = math.random(1,4)

		if (operator == 1) then

		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(10, 20)
		randomNumber2 = math.random(10, 20)
	
		correctAnswer = randomNumber1 + randomNumber2
	
		-- create question in text object
		questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "
	

	elseif (operator == 2) then
		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(10, 20)
		randomNumber2 = math.random(10, 20)
		if (randomNumber2 > randomNumber1) then
			correctAnswer = randomNumber2 - randomNumber1
			-- create question in text object
			questionObject.text = randomNumber2 .. " - " .. randomNumber1 .. " = "
		else
			correctAnswer = randomNumber1 - randomNumber2
			-- create question in text object
			questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "
		end

	elseif (operator == 3) then
		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(1, 10)
		randomNumber2 = math.random(1, 10)
	
		correctAnswer = randomNumber1 * randomNumber2
	
		-- create question in text object
		questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "

	elseif (operator == 4) then
		-- generate 2 random numbers between a max. and a min. number
		randomNumber1 = math.random(1, 10)
		randomNumber2 = math.random(1, 10)
	
		correctAnswer = randomNumber1 * randomNumber2
	
		-- create question in text object
		questionObject.text = correctAnswer .. " / " .. randomNumber2 .. " = "
		correctAnswer = randomNumber1
	end
end

local function  HideCorrect()
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	incorrectObject.isVisible = false
	AskQuestion()
end

local function NumericFeildListener( event )

	-- User begins editing "numericField" 
	if ( event.phase == "began" ) then
		

	elseif event.phase == "submitted" then

		-- when the answer is sumbmitted (enter key is pressed) set user input to user's answer 
		userAnswer = tonumber(event.target.text)

		-- if the users answer and the correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true
			timer.performWithDelay(3000, HideCorrect)
			event.target.text = ""
			counter = counter + 1
			-- display counter
			counterText = display.newText("Point Counter = "..counter, display.contentWidth/2, display.contentHeight/5, nil, 50)
			counterText:setTextColor (190/255, 100/255, 30/255)
			
		else
			incorrectObject.isVisible = true
			timer.performWithDelay(3000, HideIncorrect) 
			event.target.text = ""

		end
	end
end

--------------------------------------------------------------------------------------
-- OBJECT CREATION
--------------------------------------------------------------------------------------

-- displays a question and sets the color
questionObject = display.newText( "", display.contentWidth/3, display.contentHeight/3, nil, 60 )
questionObject:setTextColor(190/255, 100/255, 30/255)

-- create the correct text object and make it invisible
correctObject = display.newText( "Correct!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
correctObject:setTextColor(190/255, 100/255, 30/255)
correctObject.isVisible = false

-- create the incorrect text object and make it invisible
incorrectObject = display.newText( "Incorrect!", display.contentWidth/2, display.contentHeight*2/3, nil, 50 )
incorrectObject:setTextColor(190/255, 0/255, 0/255)
incorrectObject.isVisible = false

-- create numeric field
numericField = native.newTextField( 550, display.contentHeight/3, 150, 80)
numericField.inputType = "number"

-- add the event listener for the numeric field
numericField:addEventListener( "userInput", NumericFeildListener)

---------------------------------------------------------------------------------------
-- FUNCTION CALLS
---------------------------------------------------------------------------------------

-- call the function to ask the question
AskQuestion()