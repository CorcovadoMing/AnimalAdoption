--
-- Abstract: Composer Sample
--
-- Version: 1.0
-- 
-- Sample code is MIT licensed, see http://www.coronalabs.com/links/code/license
-- Copyright (C) 2011 Corona Labs Inc. All Rights Reserved.
--
-- Demonstrates use of the Composer API (scene events, transitioning, etc.)
--
-- Supports Graphics 2.0
------------------------------------------------------------
local composer = require "composer"
local widget = require "widget"
local json = require ( "json" )

catPath = system.pathForFile( "cat_data.txt", system.DocumentsDirectory )
dogPath = system.pathForFile( "dog_data.txt", system.DocumentsDirectory )
birdPath = system.pathForFile( "bird_data.txt", system.DocumentsDirectory )
rabbitPath = system.pathForFile( "rabbit_data.txt", system.DocumentsDirectory )

function saveCatData()
	--local levelseq = table.concat( levelArray, "-" )
	file = io.open( catPath, "w" )
	local encoded = json.encode(my_cat)
	print(encoded)
	file:write(encoded)
	io.close(file)
end

function saveDogData()
	--local levelseq = table.concat( levelArray, "-" )
	file = io.open( dogPath, "w" )
	local encoded = json.encode(my_dog)
	print(encoded)
	file:write(encoded)
	io.close(file)
end

function saveBirdData()
	--local levelseq = table.concat( levelArray, "-" )
	file = io.open( birdPath, "w" )
	local encoded = json.encode(my_bird)
	print(encoded)
	file:write(encoded)
	io.close(file)
end

function saveRabbitData()
	--local levelseq = table.concat( levelArray, "-" )
	file = io.open( rabbitPath, "w" )
	local encoded = json.encode(my_rabbit)
	print(encoded)
	file:write(encoded)
	io.close(file)
end



function loadData()	
	local file = io.open( catPath, "r" )
	if file then
		local dataStr = file:read( "*a" )
		my_cat = json.decode(dataStr)
		io.close( file ) -- important!	
	else
		print ("no file found")
	end

	local file = io.open( dogPath, "r" )
	if file then
		local dataStr = file:read( "*a" )
		my_dog = json.decode(dataStr)
		io.close( file ) -- important!	
	else
		print ("no file found")
	end

	local file = io.open( birdPath, "r" )
	if file then
		local dataStr = file:read( "*a" )
		my_bird = json.decode(dataStr)
		io.close( file ) -- important!	
	else
		print ("no file found")
	end

	local file = io.open( rabbitPath, "r" )
	if file then
		local dataStr = file:read( "*a" )
		my_rabbit = json.decode(dataStr)
		io.close( file ) -- important!	
	else
		print ("no file found")
	end
end


function split(str, pat)
   local t = {}
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
	 table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

local function networkListener( event )
    if ( event.isError ) then
        print( "Network error!" )
    else
        local decode, pos, msg = json.decode( event.response )
        if not decode then
    		print( "Decode failed at "..tostring(pos)..": "..tostring(msg) )
		else
    		for _, v in ipairs(decode) do
    			if(not hash[v.animal_id]) then
    				data[#data+1] = v
    				hash[v.animal_id] = true
    			end
    		end

    		for i=1, #data do
	    		local url =  data[i].album_file
				local split_url = split(url, '/')
				local tmp_image = table.remove(split_url)
				local function imageNetworkListener( event )
				    if ( event.isError ) then
				        print ( "Network error - download failed" )
				    else
			        	event.target.alpha = 0
			        	transition.to( event.target, { alpha = 1.0 } )
				    end
				end

				local path = system.pathForFile( tmp_image, system.TemporaryDirectory )
				local fhd = io.open( path )
				if fhd then
				   print( "File exists" )
				   fhd:close()
				else
					network.download( url, "GET", imageNetworkListener, tmp_image, system.TemporaryDirectory )
				end
			end

			for i=1, #data do
				if ( data[i].animal_kind == "貓") then
					cat[#cat+1] = data[i]
				end
				if (data[i].animal_kind == "狗") then
					dog[#dog+1] = data[i]
				end
				if (data[i].animal_kind == "鳥") then
					bird[#bird+1] = data[i]
				end
				if (data[i].animal_kind == "兔") then
					rabbit[#rabbit+1] = data[i]
				end
			end

			print(#cat)
			print(#dog)
			print(#bird)
			print(#rabbit)
			print("done")
		end
    end
end

-- hide device status bar
display.setStatusBar( display.HiddenStatusBar )

data = {}

rabbit = {}
bird = {}
dog = {}
cat = {}

my_type = ""

my_rabbit = {}
my_bird = {}
my_dog = {}
my_cat = {}

loadData()
print(#my_cat)

res = {}

hash = {}
network.request( "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx", "GET", networkListener )

-- load first scene
composer.gotoScene( "main_screen", "crossFade", 1000 )

--
-- Display objects added below will not respond to composer transitions
--

--[[ Uncomment to monitor app's lua memory/texture memory usage in terminal...

local function garbagePrinting()
	collectgarbage("collect")
    local memUsage_str = string.format( "memUsage = %.3f KB", collectgarbage( "count" ) )
    print( memUsage_str )
    local texMemUsage_str = system.getInfo( "textureMemoryUsed" )
    texMemUsage_str = texMemUsage_str/1000
    texMemUsage_str = string.format( "texMemUsage = %.3f MB", texMemUsage_str )
    print( texMemUsage_str )
end

Runtime:addEventListener( "enterFrame", garbagePrinting )
--]]