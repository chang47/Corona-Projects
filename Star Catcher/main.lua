display.setStatusBar( display.HiddenStatusBar)

local hudgroup = display.newGroup()
local gameGroup = display.newGroup()
local levelGroup = display.newGroup()
local stars = display.newGroup() -- Displays the stars
-- Modules
local sprite = require("sprite")
local physics = require ("physics")

local mCeil = math.ceil
local mAtan2 = math.atan2
local mPi = math.pi
local mSqrt = math.sqrt

local background
local ground
local powerShot
local arrow
local panda
local poof
local starGone
local scoreText
local gameOverDisplay

local gameGroupIsActive = false
local waitingForNewGround
local restartTimer
local counter
local timerInfo
local numSeconds = 30
local gameScore = 0
local starWidth =30
local starHeight = 30

local startNewRound = function()
	if panda then
		local activeRound = function()
			waitingForNewGround = false

			if restartTimer then
				timer.cancel( restartTimer )
			end

			ground:toFront( )
			panda.x = 240
			panda.y = 300
			panda.rotation = 0
			panda.isVisible = true
			panda.isBodyActive = true

			local pandaLoaded = function()
				
				gameIsActive = true
				panda.inAir = false
				panda.isHit = false
				panda:toFront()
				
				panda.bodyType = "static"
			end
			--transition
			transition.to(panda, {time=1000, y=225, onComplete=pandaLoaded})

		end
		activeRound()
	end
end

local callNewRound = function()
	local isGameOver = false
	local pandaGone = function()
		panda:setLinearVelocity( 0, 0 )
		panda.bodyType = "static"
		panda.isVisible = false
		panda.isVisible = false
		panda.rotation = 0

		poof.x = panda.x; poof.y = panda.y
		poof.alpha = 0
		poof.isVisible = true

		local fadePoof = function ()
			transition.to(poof, {time=100, alpha=0})
		end
		transition.to(poof, {time=50, alpha=1.0, onComplete=fadePoof})
		restartTimer = performWithDelay( 300, function()
			waitingForNewGround = true -- need ; ?
		end, 1)
	end
	local pootimer = performWithDelay( 500, pandaGone , 1 )
	if isGameOver == false then
		restartTimer = performWithDelay( 1500, startNewRound , 1 )
	end
end

local setScore = function ( scoreNum )
	local newScore = scoreNum -- Not even necessary...
	gameScore = newScore
	if gameScore < 0 then
		gameScore = 0
	end
	scoreText.text = gameScore
	scoreText.xScale = 0.5; scoreText.yScale = 0.5
	scoreText.x = (480 - (scoreText.contentWidth * 0.5)) - 15
	scoreText.y = 20
end

local callGameOver = function()
	gameIsActive = false
	physics.pause()

	panda:removeSelf()
	panda = nil
	stars:removeSelf( )
	stars = nil

	local shade = newRect( 0, 0,  480, 320 )
	shade:setFillColor( 0,0,0,255 )	
	shade.alpha = 0

	gameOverDisplay = newImage( "gameOverScreen.png" )
	gameOverDisplay.x = 240; gameOverDisplay.y = 160
	gameOverDisplay.alpha = 0

	hudgroup:insert(shade)
	hudgroup:insert(gameOverDisplay)

	transition.to(shade, {time=200, alpha=0.65})
	transition.to(gameOverDisplay, {time=500, alpha=1})

	local newScore = gameScore
	setScore(newScore)

	counter.isVisible = false
	scoreText.text = "Score: " .. gameScore
	scoreText.xScale = 0.5; scoreText.yScale = 0.5
	scoreText.x = 280
	scoreText.y = 160
	scoreText:toFront( )
	timer.performWithDelay( 1000, function()
		scoreText.isVisible = true
	end, 1 )
end

local drawBackground = function()
	background = dispaly.newImage("background.png")
	background.x = 240; background.y = 160

	gameGroup:insert(background)

	ground = newImage( "ground.png" )
	ground.x = 240; ground.y = 300 --not 320?

	local groundShape = {-240, -18, 240, 18, -240, 18,}
	physics.addBody(ground, "static", {density=1.0, bounce=0, friction=0.5, shape = groundShape})
	game.insert(ground)
end

local hud = function (  )
	local helpText = display.newImage( "help.png" )
	helpText.x = 240; helpText.y = 160
	helpText.isVisible = true
	hudgroup:insert(helpText)

	timer.performWithDelay( 10000, function (  )
		helpText.isVisible = false
	end , 1 )
	
end








