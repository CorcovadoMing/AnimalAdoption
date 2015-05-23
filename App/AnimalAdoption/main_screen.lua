---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

local image, text1, text2, text3

local function handleGetEvent( event )
    if ( "ended" == event.phase ) then
        composer.gotoScene( "scene_select", "crossFade", 1000  )
    end
end

local function handleGiveEvent( event )
    if ( "ended" == event.phase ) then
        composer.gotoScene( "give_select", "crossFade", 1000  )
    end
end

-- Called when the scene's view does not exist:
function scene:create( event )
	local sceneGroup = self.view
	local image = display.newImage( "images/main_screen.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	sceneGroup:insert( image )
end

function scene:show( event )	
	local phase = event.phase
	if "did" == phase then
		button1 = widget.newButton {
    		width = 220,
    		height = 198,
    		defaultFile = "images/give_btn.png",
		    overFile = "images/give_btn.png",
		    label = "",
		    onEvent = handleGetEvent
		}
		button1.x = display.contentCenterX
		button1.y = display.contentCenterY

		button2 = widget.newButton {
    		width = 220,
    		height = 198,
    		defaultFile = "images/get_btn.png",
		    overFile = "images/get_btn.png",
		    label = "",
		    onEvent = handleGiveEvent
		}
		button2.x = display.contentCenterX
		button2.y = display.contentCenterY + display.contentCenterY / 2 - 30
	end	
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then	
		print( "1: hide event, phase will" )
		button1.isVisible = false
		button2.isVisible = false
	end	
end

function scene:destroy( event )
	print( "((destroying scene 1's view))" )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene