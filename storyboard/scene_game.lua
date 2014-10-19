---------------------------------------------------------------------------------
-- SCENE NAME
-- Scene notes go here
---------------------------------------------------------------------------------


local globals = require("globals")

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
 
local score = 0
local scoreText
local scoreForLevelComplete

local levelNum

-- Clear previous scene
storyboard.removeAll()
 
-- local forward references should go here --
 
---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
function scene.updateScore()
  score = score + 10
  scoreText.text = score
 
  if ( score >= scoreForLevelComplete ) then
    -- level over
    if(globals.score < score) then
      globals.score = score
    end
    storyboard.gotoScene( "scene_results" )
  end
end 

function scene.createDot()
 
  local dot = display.newCircle( 0, 0, 60 )
  dot.x = display.contentCenterX
  dot.y = display.contentCenterY
 
  function dot:tap( event )
 
    scene.updateScore()
 
    self.x = math.random( 60, display.contentWidth - 60 )
    self.y = math.random( 60, display.contentHeight - 60 )    
  end
  dot:addEventListener( "tap", dot )
 
  scene.view:insert( dot )
 
end
 

 
-- Called when the scene's view does not exist:
function scene:createScene( event )
  local group = self.view
 
  levelNum = globals.levelNum
 
  scoreForLevelComplete = 50 * levelNum
 
  scoreText = display.newText( "0", 0, 0, globals.font.bold, 32 )
  scoreText.x = display.contentCenterX
  scoreText.y = 32
 
  group:insert( scoreText )
 
  self.createDot()
end
-- Called BEFORE scene has moved onscreen:
function scene:willEnterScene( event )
  local group = self.view
 
end
 
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
  local group = self.view
 
end
 
-- Called when scene is about to move offscreen:
function scene:exitScene( event )
  local group = self.view
 
end
 
-- Called AFTER scene has finished moving offscreen:
function scene:didExitScene( event )
  local group = self.view
 
end
 
-- Called prior to the removal of scene's "view" (display view)
function scene:destroyScene( event )
  local group = self.view
 
end
 
-- Called if/when overlay scene is displayed via storyboard.showOverlay()
function scene:overlayBegan( event )
  local group = self.view
  local overlay_name = event.sceneName  -- name of the overlay scene
 
end
 
-- Called if/when overlay scene is hidden/removed via storyboard.hideOverlay()
function scene:overlayEnded( event )
  local group = self.view
  local overlay_name = event.sceneName  -- name of the overlay scene
 
end
 
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
 
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )
 
-- "willEnterScene" event is dispatched before scene transition begins
scene:addEventListener( "willEnterScene", scene )
 
-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )
 
-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )
 
-- "didExitScene" event is dispatched after scene has finished transitioning out
scene:addEventListener( "didExitScene", scene )
 
-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )
 
-- "overlayBegan" event is dispatched when an overlay scene is shown
scene:addEventListener( "overlayBegan", scene )
 
-- "overlayEnded" event is dispatched when an overlay scene is hidden/removed
scene:addEventListener( "overlayEnded", scene )
 
---------------------------------------------------------------------------------
 
return scene