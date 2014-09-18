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
		img = display.newCircle( _W, _H, 10 )
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

function main()
	mainMenu()	
end

main()