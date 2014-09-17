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