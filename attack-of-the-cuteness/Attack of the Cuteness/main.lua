-- Project: Attack of the Cuteness Game
-- http://MasteringCoronaSDK.com
-- Version: 1.0
-- Copyright 2013 J. A. Whye. All Rights Reserved.
-- "Space Cute" art by Daniel Cook (Lostgarden.com) 

-- housekeeping stuff

display.setStatusBar(display.HiddenStatusBar)

local centerX = display.contentCenterX
local centerY = display.contentCenterY

-- set up forward references

local spawnEnemy
local gameTitle
local score = 0
local scoreTxt
local hitPlanet
local planet
local speedBump = 0
-- preload audio

local sndKill = audio.loadSound('boing-1.wav')
local sndBlast = audio.loadSound( "blast.mp3" )


-- create play screen
local function createPlayScreen()	
	local background = display.newImage("background.png")
	background.y = 130
	background.alpha = 0

	planet = display.newImage("planet.png")
	planet.x = centerX
	planet.y = display.contentHeight + 60
	planet.alpha = 0

	transition.to(background, {time=2000, y=centerY, x=centerX, alpha=1})

	local function showTitle(  )
		gameTitle = display.newImage( "gametitle.png" )
		gameTitle.alpha = 0
		gameTitle:scale( 4, 4 )
		transition.to(gameTitle, {time=500, alpha=1, xScale=1, yScale=1})
		startGame()
	end

	transition.to( planet, { time=2000, y=centerY, alpha=1, onComplete=showTitle})
end
-- game functions


function spawnEnemy(  )
	local enemypics = {"beetleship.png", "octopus.png", "rocketship.png"}
	local enemy = display.newImage(enemypics[math.random(#enemypics)])
	if math.random(2) == 1 then
		enemy.x = math.random(-100, -10)
	else
		enemy.x = math.random(display.contentHeight + 10, display.contentWidth+100)
		enemy.xScale = -1
	end
	enemy.y = math.random(display.contentHeight)

	enemy.trans = transition.to(enemy, {x=centerX, y=centerY, time=math.random(2500-speedBump, 4500-speedBump), onComplete=hitPlanet})
	enemy:addEventListener( "tap", shipSmash )
	speedBump = speedBump + 50
end

function startGame(  )
	local text = display.newText( "Tap here to start. Protect the planet!", 0, 0, "Helvetica", 24 )
	text.x = centerX
	text.y = display.contentHeight - 30
	local function goAway(event)
		display.remove( event.target )
		display.remove(gameTitle)
		gameTitle = nil
		text = nil
		score = 0
		scoreTxt = display.newText( "Sc0re: 0", 0, 0, "Helvetica", 24 )
		scoreTxt.x = centerX
		scoreTxt.y = 10
		planet.numHits = 10
		planet.alpa = 1
		speedBump = 0
		spawnEnemy()
	end
	text:addEventListener( 'tap', goAway )
end

local function planetDamage(  )
	planet.numHits = planet.numHits - 2
	planet.alpha = planet.numHits / 10
	if planet.numHits < 2 then
		planet.alpha = 0
		timer.performWithDelay( 1000, startGame )
		--lose audio
	else
		local function goAway(obj)
			planet.xScale = 1
			planet.yScale = 1
			planet.alpha = planet.numHits / 10
		end
		transition.to(planet, {time=200, xScale=1.2, yScale=1.2, alpha=1, onComplete=goAway})
	end
end

function hitPlanet( obj )
	display.remove( obj )
	planetDamage()
	audio.play(sndBlast)
	if planet.numHits > 1 then
		spawnEnemy()
	end
end

function shipSmash( event )
	local obj = event.target
	display.remove(obj);
	obj = nil
	audio.play(sndKill)
	score = score + 28
	scoreTxt.text = "Score: " .. score
	transition.cancel(event.target.trans)
	spawnEnemy()
	return true
end

createPlayScreen()
