---------------------------------------------------------------------------------
--
-- scene1.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()


local image, text1, text2, text3, memTimer


local function handleButtonEvent( event )
    if ( "ended" == event.phase ) then
        composer.gotoScene( "scene2", "fade", 400  )
    end
end


-- Called when the scene's view does not exist:
function scene:create( event )
	local sceneGroup = self.view
	local image = display.newImage( "images/main_screen.jpg" )
	local effect = require( "kernel_filter_example_blur_gaussian_gl" )
	graphics.defineEffect( effect )

	image.x = display.contentCenterX
	image.y = display.contentCenterY
	image.fill.effect = "filter.exampleBlurGaussian"
	image.fill.effect.horizontal.blurSize = 20
	image.fill.effect.vertical.blurSize = 20
	sceneGroup:insert( image )
end

function scene:show( event )	
	local phase = event.phase	
	if "did" == phase then
		button1 = widget.newButton {
    		id = "button1",
    		label = "Default",
    		onEvent = handleButtonEvent
		}
		button1.x = display.contentCenterX
		button1.y = display.contentCenterY

		-- remove previous scene's view
		composer.removeScene( "scene4" )
	end	
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then	
		print( "1: hide event, phase will" )
		button1.isVisible = false
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