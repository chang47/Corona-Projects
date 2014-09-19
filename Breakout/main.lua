-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
 
local physics = require "physics"

display.setStatusBar(display.HiddenStatusBar)

physics.start()
physics.setGravity(0, 0)

system.setAccelerometerInterval( 100 )

local menuScreenGroup
local mmScreen
local playBtn

local background
local paddle
local brick
local ball

local scoreText
local scoreNum
local levelText
local levelNum

local alertDisplayGroup -- display.newGroup()
local alertBox
local conditionDisplay
local messageText

local _W = display.contentWidth / 2
local _H = display.contentHeight / 2
local bricks = display.newGroup()
local brickWidth = 35
local brickHeight = 15
local row
local column
local score = 0
local scoreIncrease = 100
local currentLevel
local vx = 3
local vy = -3
local gameEvent = ""

local isSimulator = "simulator" == system.getInfo("environment")

print("hi")

function loadGame( event )
	if event.target.name == "playbutton" then
		transition.to(menuScreenGroup, {time = 0, alpha=0, onComplete=addGameScreen})
		playBtn:removeEventListener('tap', loadGame)
	end
end

function mainMenu()
	menuScreenGroup = display.newGroup()
	mmScreen = display.newImage('img/mmScreen.png', 0, 0, true)
	print(_W)
	mmScreen.x = _W
	mmScreen.y = _H

	playBtn = display.newImage('img/playBtn.png')

	playBtn.x = _W; playBtn.y = _H + 50
	playBtn.name = "playbutton"

	menuScreenGroup:insert(mmScreen)

	menuScreenGroup:insert(playBtn)
	playBtn:addEventListener("tap", loadGame)
end

function addGameScreen() 
	background = display.newImage("img/bg.png", 0, 0, true)
	background.x = _W
	background.y = _H

	paddle = display.newImage("img/paddle.png")
	paddle.x = 240; paddle.y = 300
	paddle.name = "paddle"

	ball = display.newImage("img/ball.png")
	ball.x = 240; ball.y = 290
	ball.name = "ball"

	scoreText = display.newText("Score:", 100, 10, "Arial", 14)
	scoreText:setTextColor(255,255,255,255)

	scoreNum = display.newText("0", 140, 10, "Arial", 14)
	scoreNum:setTextColor(255, 255,255,255)

	levelText = display.newText("Level:", 420, 10, "Arial", 14)
	levelText:setTextColor(255,255,255,255)

	levelNum = display.newText("1", 460, 10, "Arial", 14)
	levelNum:setTextColor(255,255,255,255)

	gameLevel1()
end

function gameLevel1(  )
	currentLevel = 1
	bricks:toFront()

	local numOfRows = 4
	local numOfColumns = 4
	local brickPlacement = {x = _W - (brickWidth * numOfColumns) / 2 + 20, y= 50}
	
	for row = 0, numOfRows - 1 do
		for column=0, numOfColumns - 1 do
			local brick = display.newImage("img/brick.png")
			brick.name = "brick"
			brick.x = brickPlacement.x + (column * brickWidth)
			brick.y = brickPlacement.y + (row * brickHeight)	
			physics.addBody(brick, "static", {density = 1, friction = 0, bounce = 0})
			bricks.insert(bricks, brick) -- ???
		end
	end
end

function gameLevel2(  )
	currentLevel = 2
	bricks:toFront()

	local numOfRows = 5
	local numOfColumns = 8
	local brickPlacement = {x = _W - (brickWidth * numOfColumns) / 2 + 20, y= 50}
	
	for row=0,numOfRows - 1 do
		for col=0,numOfColumns - 1 do
			local brick = display.newImage("img/brick.png")
			brick.name = "brick"
			brick.x = brickPlacement.x + (column * brickWidth)
			brick.y = brickPlacement.y + (row * brickHeight)	
			physics.addBody(brick, "static", {density = 1, friction = 0, bounce = 0})
			bricks.insert(bricks, brick) -- ???
		end
	end
end

function alertScreen( title, message )
	alertBox = display.newImage("alertBox.png")
	alertBox.x = 240; alertBox.y = 160
	transition.from(alertBox, {time = 500, xScale = 0.5, yScale = 0.5,
		transition = easing.outExpo})

	conditionDisplay = display.newText(title, 0, 0, "Arial", 38)
	conditionDisplay:setTextColor(255,255,255,255)
	conditionDisplay.xScale = 0.5
	conditionDisplay.yScale = 0.5
	--
	conditionDisplay.x = display.contentCenterX
	conditionDisplay.y = display.contentHeightY - 15

	messageText = display.newText(message, 0, 0, "Arial", 24)
	messageText:setTextColor(255,255,255,255)
	messageText.xScale = 0.5
	messageText.yScale = 0.5
	--
	messageText.x = display.contentCenterX
	messageText.y = display.contentHeightY

	alertDisplayGroup = display.newGroup()
	alertDisplayGroup:insert(alertBox)
	alertDisplayGroup:insert(conditionDisplay)
	alertDisplayGroup:insert(messageText)
end

function main(  )
	mainMenu()
end

main()