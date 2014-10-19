-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------


local json = require('json')

function exists(filename)
	local path = system.pathForFile( filename, system.DocumentsDirectory)
	local file = io.open( path , 'r' )
	if file then
		io.close( file )
		return true
	else
		return false
	end
end

function saveTable(filename, table)
	print(filename)
	print(table)
	local path = system.pathForFile( filename, system.DocumentsDirectory )
	print(path)
	local file = io.open(path, "w")
	if file then
		local contents = json.encode(table)
		file:write(contents)
		io.close(file)
		return true
	else 
		return false
	end
end

function loadTable(filename)
	print('make it in here')
	local path = system.pathForFile( filename, system.DocumentsDirectory )
	print(path)
	local contents = ""
	local myTable = {}
	local file = io.open(path, "r")
	if file then
		local contents = file:read("*a")
		myTable = json.decode( contents )
		io.close( file )
		return myTable
	end
	return nil
end








local file = require( "save" )
local score = 0
local scoreText = display.newText("Score: " .. score, 0, 0, "Helvetica", 36)
scoreText.x = display.contentCenterX
scoreText. y = 30
local myGameSettings = {}
if(exists('save.json')) then
	myGameSettings = loadTable('save.json')
end
--file.loadTable('save.json')
local highscore = 0
if exists('save.json') then
	print("ain't nil")
	highscore = myGameSettings.highscore
end 



local highscoreText = display.newText("Highscore: " .. highscore, 0, 0, "Helvetica", 36)
highscoreText.x = display.contentCenterX
highscoreText. y = 70

local box = display.newRect( display.contentCenterX, display.contentCenterY, 50, 50 )

local done = display.newText("Save", 0, 0, "Helvetica", 36)
done.y = display.contentHeight - 30
done.x = display.contentCenterX - 60

local reset = display.newText("Reset", 0, 0, "Helvetica", 36)
reset.y = display.contentHeight - 30
reset.x = display.contentCenterX + 60

function onTap(event)
	score = score + 10
	if(score > highscore) then
		highscore = score
		highscoreText.text = "Highscore: " .. highscore
	end
	scoreText.text = "Score: " .. score
	--display.remove( box )
	spawnEnemy()
end

function spawnEnemy()
	box.x = math.random(display.contentWidth - 20)
	box.y = math.random(display.contentHeight - 20)
end

box:addEventListener( 'tap', onTap )

function saves()
	myGameSettings.highscore = highscore
	file.saveTable('save.json', myGameSettings, '23423') --
end
done:addEventListener( 'tap', saves)

function resets(event)
	score = 0;
	scoreText.text = "Score: " .. score
end
reset:addEventListener( 'tap', resets )


