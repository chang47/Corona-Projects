-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

display.setStatusBar(display.HiddenStatusBar)
local bg = display.newRect(display.screenOriginX,
						   display.screenOriginY,
						   display.pixelWidth,
						   display.pixelHeight)
bg.x = display.contentCenterX
bg.y = display.contentCenterY
bg:setFillColor(137/255, 168/255, 254/255)

local globals = require("globals")
globals.levelNum = 1
globals.score = 0

local storyboard = require("storyboard")
storyboard.gotoScene("scene_splash")