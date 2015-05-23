local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

local image, text1, text2, text3

local function handleCat( event )
    if ( "ended" == event.phase ) then
    	my_type = "cat"
        composer.gotoScene( "give_configure", "crossFade", 1000  )
    end
end

local function handleDog( event )
    if ( "ended" == event.phase ) then
    	my_type = "dog"
        composer.gotoScene( "give_configure", "crossFade", 1000  )
    end
end

local function handleBird( event )
    if ( "ended" == event.phase ) then
    	my_type = "bird"
        composer.gotoScene( "give_configure", "crossFade", 1000  )
    end
end

local function handleRabbit( event )
    if ( "ended" == event.phase ) then
    	my_type = "rabbit"
        composer.gotoScene( "give_configure", "crossFade", 1000  )
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
    		width = 180,
    		height = 180,
    		defaultFile = "images/cat.png",
		    overFile = "images/cat.png",
		    label = "",
		    onEvent = handleCat
		}
		button1.x = display.contentCenterX - 100
		button1.y = display.contentCenterY

		button2 = widget.newButton {
    		width = 180,
    		height = 180,
    		defaultFile = "images/bird.png",
		    overFile = "images/bird.png",
		    label = "",
		    onEvent = handleBird
		}
		button2.x = display.contentCenterX - 100
		button2.y = display.contentCenterY + display.contentCenterY / 2 - 30

		button3 = widget.newButton {
    		width = 180,
    		height = 180,
    		defaultFile = "images/dog.png",
		    overFile = "images/dog.png",
		    label = "",
		    onEvent = handleDog
		}
		button3.x = display.contentCenterX + 100
		button3.y = display.contentCenterY

		button4 = widget.newButton {
    		width = 180,
    		height = 180,
    		defaultFile = "images/rabbit.png",
		    overFile = "images/rabbit.png",
		    label = "",
		    onEvent = handleRabbit
		}
		button4.x = display.contentCenterX + 100
		button4.y = display.contentCenterY + display.contentCenterY / 2 - 30
	end	
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then	
		print( "1: hide event, phase will" )
		button1.isVisible = false
		button2.isVisible = false
		button3.isVisible = false
		button4.isVisible = false
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