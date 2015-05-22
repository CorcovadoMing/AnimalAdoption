---------------------------------------------------------------------------------
--
-- scene2.lua
--
---------------------------------------------------------------------------------

local composer = require( "composer" )
local widget = require( "widget" )
local scene = composer.newScene()

local image, text1, text2, text3, memTimer

local function onRowRender( event )
	local row = event.row
	local url =  data[row.index].album_file
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
	local title = data[row.index].animal_kind .. ', ' .. data[row.index].animal_colour .. '\n' .. data[row.index].animal_place
	local rowTitle = display.newText(row, title, 0, 0, native.systemFont, 40)
	rowTitle.anchorX = 0
	rowTitle.x = 20
	rowTitle.y = row.contentHeight - 120
	row:insert(rowTitle)


end

function scene:create( event )
	local sceneGroup = self.view
	
	image = display.newImage( "images/main_screen.jpg" )
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	
	sceneGroup:insert( image )
end

function scene:show( event )
	
	local phase = event.phase
	
	if "did" == phase then
	
		local tableView = widget.newTableView {
		    left = 0,
		    top = 100,
		    height = 1136 - 100,
		    width = 640,
		    onRowRender = onRowRender,
		    onRowTouch = onRowTouch,
		    listener = scrollListener
		}

		for i = 1, #data do
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