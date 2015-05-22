---------------------------------------------------------------------------------
--
-- scene2.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )
local json = require "json"
local utf8 = require "utf8"
local scene = composer.newScene()

local image, text1, text2, text3, memTimer

local function networkListener( event )

    if ( event.isError ) then
        print( "Network error!" )
    else
        -- print ( "RESPONSE: " .. event.response )
        local decoded, pos, msg = json.decode( event.response )
        if not decoded then
    		print( "Decode failed at "..tostring(pos)..": "..tostring(msg) )
		else
    		for _, v in pairs(decoded) do
    			text2.text = v.animal_kind
    		end
		end
    end
end

local function onSceneTouch( self, event )
	if event.phase == "began" then
		
		composer.gotoScene( "scene3", "fade", 400  )
		
		return true
	end
end

function scene:create( event )
	network.request( "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx", "GET", networkListener )
	local sceneGroup = self.view
	
	image = display.newImage( "bg2.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	
	sceneGroup:insert( image )
	
	image.touch = onSceneTouch
	
	text1 = display.newText( "Scene 2", 0, 0, native.systemFontBold, 24 )
	text1:setFillColor( 255 )
	text1.x, text1.y = display.contentWidth * 0.5, 50
	sceneGroup:insert( text1 )
	
	text2 = display.newText( "MemUsage: ", 0, 0, native.systemFont, 50 )
	text2:setFillColor( 255 )
	text2.x, text2.y = display.contentWidth * 0.5, display.contentHeight * 0.5
	sceneGroup:insert( text2 )
	
	text3 = display.newText( "Touch to continue.", 0, 0, native.systemFontBold, 18 )
	text3:setFillColor( 255 ); text3.isVisible = false
	text3.x, text3.y = display.contentWidth * 0.5, display.contentHeight - 100
	sceneGroup:insert( text3 )
	
	print( "\n2: create event" )
end

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		print( "2: show event, phase did" )
	
		-- remove previous scene's view
		composer.removeScene( "main_screen" )
	
		-- Update Lua memory text display
		local showMem = function()
			image:addEventListener( "touch", image )
			text3.isVisible = true
			text2.text = text2.text .. collectgarbage("count")/1000 .. "MB"
			text2.x = display.contentWidth * 0.5
		end
		memTimer = timer.performWithDelay( 1000, showMem, 1 )
	
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	if "will" == phase then
	
		print( "2: hide event, phase will" )
	
		-- remove touch listener for image
		image:removeEventListener( "touch", image )
	
		-- cancel timer
		timer.cancel( memTimer ); memTimer = nil;
	
		-- reset label text
		text2.text = "MemUsage: "
	end
end

function scene:destroy( event )
	
	print( "((destroying scene 2's view))" )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene