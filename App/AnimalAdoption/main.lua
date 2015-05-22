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

-- hide device status bar
display.setStatusBar( display.HiddenStatusBar )

-- require controller module
local composer = require "composer"

local widget = require "widget"

-- load first scene
composer.gotoScene( "main_screen", "fade", 400 )

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