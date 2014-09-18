-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
display.setStatusBar( HiddenStatusBar )

local physics = require "physics"

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

print("hi")

function loadGame( event )
	if event.target.name == "playbutton" then
		transition.to(menuScreenGroup, time{time = 0, alpha=0, onComplete=addGameScreen})
		playBtn.removeEventListener('tap', loadGame)
	end
end

function mainMenu()
	menuScreenGroup = display.newGroup()
	mmScreen = display.newImage('img/mmScreen.png', 0, 0, true)
	print(_W)
	mmScreen.x = _W
	mmScreen.y = _H

	playBtn = display.newImage('img/playBtn.png')
	--playBtn:setReferencePoint(display.CenterReferencePoint)
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