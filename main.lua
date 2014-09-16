-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here
-- textObject = display.newText( "Hello World", 100, 50, "Times New Roman", 36 );
-- textObject:setTextColor( 255, 255, 255, 100 );
local physics = require "physics"
local background = display.newImage('rainbow@2x.png', true);
background.x = display.contentWidth/2;
background.y = display.contentWidth/2;

local rect = display.newRect(110, 100, 250, 250)
rect:setFillColor(255, 255, 255)
--rect:setStrokeColor(40, 160, 2)
display.setStatusBar(display.HiddenStatusBar)