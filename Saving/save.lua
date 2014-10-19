local json = require('json')

local file = {}

function file.exists(filename)
	local path = system.pathForFile( filename, system.DocumentsDirectory)
	local file = io.open( path , 'r' )
	if file then
		io.close( file )
		return true
	else
		return false
	end
end

function file.saveTable(filename, table, f2)
	print(filename)
	print(table)
	print(f2)
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

function file.loadTable(filename)
	print('make it in here')
	local path = system.pathForFile( filename, system.DocumentsDirectory )
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

function file.print()
	print("sdgwerwe")
end


return file