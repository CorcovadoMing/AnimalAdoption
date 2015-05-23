---------------------------------------------------------------------------------
--
-- scene2.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

local image, text1, text2, text3, memTimer
local ox, oy = math.abs(display.screenOriginX), math.abs(display.screenOriginY)


local function onRowRender( event )
	local sex = {}
	sex["M"] = "公"
	sex["F"] = "母"
	sex["N"] = "性別未提供"

	local row = event.row
	local url = res[row.index].album_file
	local split_url = split(url, '/')
	local tmp_image = table.remove(split_url)
	local rowImage
	local path = system.pathForFile( tmp_image, system.TemporaryDirectory )
	local fhd = io.open( path )
	if fhd then
		fhd:close()
		rowImage = display.newImage( tmp_image, system.TemporaryDirectory)
	else
		rowImage = display.newImage( "images/main_screen.jpg" )
	end
	rowImage:scale(640/rowImage.width, row.contentHeight/rowImage.height)
	rowImage.x = 320
	rowImage.y = row.contentHeight/2
	row:insert(rowImage)

	local title = res[row.index].animal_kind .. ', ' .. res[row.index].animal_colour .. ", " .. sex[res[row.index].animal_sex] .. '\n' .. res[row.index].shelter_name
	local rowTitle = display.newText(row, title, 0, 0, native.systemFont, 40)
	rowTitle.anchorX = 0
	rowTitle.x = 20
	rowTitle.y = row.contentHeight - 120
	rowTitle:setFillColor(0.8, 0.8, 0.8)
	row:insert(rowTitle)

	local saperator = display.newRect(320, row.contentHeight - 5, 640, 10)
	saperator:setFillColor(0.8, 0.8, 0.8)
	row:insert(saperator)
end

function scene:create( event )
	local sceneGroup = self.view
end

function scene:show( event )
	local tableView -- for shadow reference
	local navigator
	local descript_image
	local backButton
	local nav_title
	local image
	local itemSelected

	local function goBack( event )
		homeButton.isVisible = true
		transition.to( tableView, { x=display.contentWidth*0.5, time=600, transition=easing.outQuint } )
		transition.to( descript_image, { x=display.contentWidth+descript_image.contentWidth, time=500, transition=easing.outQuint } )
		transition.to( itemSelected, { x=display.contentWidth+itemSelected.contentWidth, time=700, transition=easing.outQuint } )
		transition.to( event.target, { x=display.contentWidth+event.target.contentWidth, time=900, transition=easing.outQuint } )
	end

	local function goHome( event )
		composer.gotoScene( "main_screen", "crossFade", 800  )
		tableView.isVisible = false
		navigator.isVisible = false
		nav_title.isVisible = false
		homeButton.isVisible = false
		image.isVisible = false
	end

	bodytype = {}
	bodytype["MINI"] = "迷你"
	bodytype["SMALL"] = "小"
	bodytype["MEDIUM"] = "中"
	bodytype["BIG"] = "大"

	age = {}
	age["CHILD"] = "年幼"
	age["ADULT"] = "成熟"

	local function onRowTouch( event )
		local phase = event.phase
		local row = event.target
		if ( "release" == phase) then
			local url =  res[row.index].album_file
			local split_url = split(url, '/')
			local tmp_image = table.remove(split_url)
			descript_image = display.newImage( tmp_image, system.TemporaryDirectory)
			descript_image:scale(640/descript_image.width, row.contentHeight/descript_image.height)
			descript_image.x = display.contentWidth+descript_image.contentWidth
			descript_image.y = descript_image.contentHeight/2 + 100

			itemSelected.text = "種類: " .. res[row.index].animal_kind .. "\n" .. "體型: " .. bodytype[res[row.index].animal_bodytype] .. "\n" .. "顏色: " .. res[row.index].animal_colour .. "\n" .. "年齡: " .. age[res[row.index].animal_age] .. "\n" .. "收容所: " .. res[row.index].shelter_name .. "\n" .. "刊登時間: " .. res[row.index].animal_opendate .. "\n" .. "截止時間: " .. res[row.index].animal_closeddate
			itemSelected:setFillColor(0.4, 0.2, 0.2)

			transition.to( tableView, { x=((display.contentWidth/2)+ox+ox)*-1, time=500, transition=easing.outQuint } )
			transition.to( descript_image, { x=display.contentCenterX, time=700, transition=easing.outQuint } )
			transition.to( itemSelected, { x=itemSelected.contentWidth / 2 + 20, time=900, transition=easing.outQuint } )
			transition.to( backButton, { x=50, time=1100, transition=easing.outQuint } )
			homeButton.isVisible = false
		end
	end

	local phase = event.phase
	
	if "did" == phase then

		image = display.newImage( "images/second_screen.png" )
		image.x = display.contentCenterX
		image.y = display.contentCenterY + 50

		itemSelected = display.newText( "No description", 0, 0, native.systemFont, 40 )
		itemSelected.x = display.contentWidth + itemSelected.contentWidth
		itemSelected.y = 780

		tableView = widget.newTableView {
		    left = 0,
		    top = 100,
		    height = 1136 - 100,
		    width = 640,
		    backgroundColor = { 0.8, 0.8, 0.8 },
		    onRowRender = onRowRender,
		    onRowTouch = onRowTouch,
		    listener = scrollListener
		}

		navigator = display.newRect(320, 50, 640, 100)
		navigator:setFillColor(1.0,0.9,0.5)

		nav_title = display.newImage( "images/logo.png" )
		nav_title:scale(0.6, 0.6)
		nav_title.x = display.contentCenterX
		nav_title.y = 50

		homeButton = widget.newButton {
			height = 50,
			width = 60,
			defaultFile = "images/home.png",
		    overFile = "images/home.png",
			onRelease = goHome
		}
		homeButton.x = 50
		homeButton.y = 50

		backButton = widget.newButton {
			height = 50,
			width = 60,
			defaultFile = "images/back.png",
		    overFile = "images/back.png",
			onRelease = goBack
		}
		backButton.x = display.contentWidth+backButton.contentWidth
		backButton.y = 50



		for i = 1, #res do
		    -- Insert a row into the tableView
		    tableView:insertRow {
		    	rowHeight = 500,
		    	rowColor = {default={1,0,0,1}}
			}
		end
		-- remove previous scene's view
		composer.removeScene( "main_screen" )	
	end
	
end

function scene:hide( event )
	
	local phase = event.phase
	if "will" == phase then
	end
end

function scene:destroy( event )
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene