local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

local image, text1, text2, text3

-- Called when the scene's view does not exist:
function scene:create( event )
	local sceneGroup = self.view
	local image = display.newImage( "images/main_screen.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	sceneGroup:insert( image )

	itemSelected = display.newText( "發現地點: ", 10, 10, native.systemFont, 30 )
	itemSelected.x = 180
	itemSelected.y = 500
	itemSelected:setFillColor(0, 0, 0)
	sceneGroup:insert( itemSelected )

	itemSelected2 = display.newText( "目前所在: ", 10, 10, native.systemFont, 30 )
	itemSelected2.x = 180
	itemSelected2.y = 540
	itemSelected2:setFillColor(0, 0, 0)
	sceneGroup:insert( itemSelected2 )

	itemSelected3 = display.newText( "性別: ", 10, 10, native.systemFont, 30 )
	itemSelected3.x = 180
	itemSelected3.y = 580
	itemSelected3:setFillColor(0, 0, 0)
	sceneGroup:insert( itemSelected3 )

	itemSelected4 = display.newText( "年齡: ", 10, 10, native.systemFont, 30 )
	itemSelected4.x = 180
	itemSelected4.y = 620
	itemSelected4:setFillColor(0, 0, 0)
	sceneGroup:insert( itemSelected4 )

	itemSelected5 = display.newText( "體型: ", 10, 10, native.systemFont, 30 )
	itemSelected5.x = 180
	itemSelected5.y = 660
	itemSelected5:setFillColor(0, 0, 0)
	sceneGroup:insert( itemSelected5 )

	itemSelected6 = display.newText( "毛色: ", 10, 10, native.systemFont, 30 )
	itemSelected6.x = 180
	itemSelected6.y = 700
	itemSelected6:setFillColor(0, 0, 0)
	sceneGroup:insert( itemSelected6 )

	itemSelected7 = display.newText( "徵收期限: ", 10, 10, native.systemFont, 30 )
	itemSelected7.x = 180
	itemSelected7.y = 740
	itemSelected7:setFillColor(0, 0, 0)
	sceneGroup:insert( itemSelected7 )
end

local defaultField7

function scene:show( event )	
	local phase = event.phase
	if "did" == phase then

		local my_data = {}
		local date = os.date( "*t" ) 
		my_data["animal_opendate"] = date.year.."-"..date.month.."-"..date.day
		my_data["album_file"] = "/a/a/a.png"
		local function place( event )
		    if ( event.phase == "ended" or event.phase == "submitted" ) then
		        -- do something with defaultField text
		        my_data["animal_place"] = event.target.text
		    end
		end

		local function current_place( event )
		    if ( event.phase == "ended" or event.phase == "submitted" ) then
		        -- do something with defaultField text
		        my_data["shelter_name"] = event.target.text
		    end
		end

		local function sex( event )
		    if ( event.phase == "ended" or event.phase == "submitted" ) then
		        -- do something with defaultField text
		        my_data["animal_sex"] = event.target.text
		    end
		end

		local function age( event )
		    if ( event.phase == "ended" or event.phase == "submitted" ) then
		        -- do something with defaultField text
		        my_data["animal_age"] = event.target.text
		    end
		end

		local function bodytype( event )
		    if ( event.phase == "ended" or event.phase == "submitted" ) then
		        -- do something with defaultField text
		        my_data["animal_bodytype"] = event.target.text
		    end
		end

		local function colour( event )
		    if ( event.phase == "ended" or event.phase == "submitted" ) then
		        -- do something with defaultField text
		        my_data["animal_colour"] = event.target.text
		    end
		end

		local function closeddate( event )
		    if ( event.phase == "ended" or event.phase == "submitted" ) then
		        -- do something with defaultField text
		        my_data["animal_closeddate"] = event.target.text
		    end
		end

		local function completeData( event )
			if ( "ended" == event.phase ) then
        		if ("cat" == my_type) then
        			my_data["animal_kind"] = "貓"
        			my_cat[#my_cat+1] = my_data
        			saveCatData()
        			res = my_cat
        		end
        		if ("dog" == my_type) then
        			my_data["animal_kind"] = "狗"
        			my_dog[#my_dog+1] = my_data
        			saveDogData()
        			res = my_dog
        		end
        		if ("bird" == my_type) then
        			my_data["animal_kind"] = "鳥"
        			my_bird[#my_bird+1] = my_data
        			saveBirdData()
        			res = my_bird
        		end
        		if ("rabbit" == my_type) then
        			my_data["animal_kind"] = "兔"
        			my_rabbit[#my_rabbit+1] = my_data
        			saveRabbitData()
        			res = my_rabbit
        		end
        		composer.gotoScene( "give_list", "crossFade", 1000  )
        		print(#my_cat)
    		end
		end
		-- Create text field
		defaultField = native.newTextField( 400, 500, 300, 30 )
		defaultField:addEventListener( "userInput", place )
		defaultField2 = native.newTextField( 400, 540, 300, 30 )
		defaultField2:addEventListener( "userInput", current_place )
		defaultField3 = native.newTextField( 400, 580, 300, 30 )
		defaultField3:addEventListener( "userInput", sex )
		defaultField4 = native.newTextField( 400, 620, 300, 30 )
		defaultField4:addEventListener( "userInput", age )
		defaultField5 = native.newTextField( 400, 660, 300, 30 )
		defaultField5:addEventListener( "userInput", bodytype )
		defaultField6 = native.newTextField( 400, 700, 300, 30 )
		defaultField6:addEventListener( "userInput", colour )
		defaultField7 = native.newTextField( 400, 740, 300, 30 )
		defaultField7:addEventListener( "userInput", closeddate )

		button1 = widget.newButton {
    		width = 180,
    		height = 180,
    		defaultFile = "images/confirm.png",
		    overFile = "images/confirm.png",
		    label = "",
		    onEvent = completeData
		}
		button1.x = display.contentCenterX
		button1.y = 900
	end
end

function scene:hide( event )
	local phase = event.phase
	if "will" == phase then	
		print( "1: hide event, phase will" )
		button1.isVisible = false
		defaultField:removeSelf( )
		defaultField2:removeSelf( )
		defaultField3:removeSelf( )
		defaultField4:removeSelf( )
		defaultField5:removeSelf( )
		defaultField6:removeSelf( )
		defaultField7:removeSelf( )
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