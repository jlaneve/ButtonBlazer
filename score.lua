-- Score Module
--

local M = {} -- create our local M = {}
M.score = 0

function M.init( options )
	local options = opt
	local opt = {}
	opt.fontSize = 24
	opt.font = native.systemFontBold
	opt.x = display.contentCenterX
	opt.y = 57
	opt.maxDigits = 4
	opt.leadingZeros = false
	M.filename = "scorefile.txt"
	return M.scoreText
end

function M.set( score )
	M.score = score
	M.scoreText.text = string.format(M.format, M.score)

end

function M.get()
	return M.score
end

function M.add( amount )
	M.score = M.score + amount
	M.scoreText.text = string.format(M.format, M.score)
end

function M.save()
	local path = system.pathForFile( M.filename, system.DocumentsDirectory)
    local file = io.open(path, "w")
    if file then
        local contents = tostring( M.score )
        file:write( contents )
        io.close( file )
        return true
    else
    	print("Error: could not read ", M.filename, ".")
        return false
    end
end

function M.load()
    local path = system.pathForFile( M.filename, system.DocumentsDirectory)
    local contents = ""
    local file = io.open( path, "r" )
    if file then
         -- read all contents of file into a string
         local contents = file:read( "*a" )
         local score = tonumber(contents);
         io.close( file )
         return score
    end
    print("Could not read scores from ", M.filename, ".")
    return nil
end

return M
