local composer = require( "composer" )
local scene = composer.newScene()
--
-- Use widget.newButton and widget.newScrollView
--
local widget = require( "widget" )
--
-- My "global" like data table, see http://coronalabs.com/blog/2013/05/28/tutorial-goodbye-globals/
--
-- This will contain relevent data for tracking the current level, max levels, number of stars earned
-- per level and score per level (Not used in this tutorial) as well as other settings
--
local myData = require( "mydata" )
--
-- Use a vector star for demo purposes, you probably would want a graphic for this.  Math courtesy of:
-- http://www.smiffysplace.com/stars.ht
-- Button handler to cancel the level selection and return to the menu
--

local path = system.pathForFile( "scoreTimer.txt", system.DocumentsDirectory )
local file = io.open( path , "r" )
local scoreSaved = file:read("*a")
io.close( file )
file = nil

tappingSpeed = scoreSaved/10

audio.loadSound( "blip1.wav" )
audio.loadSound( "blip2.wav" )


local function handleCancelButtonEvent( event )
    if ( "ended" == event.phase ) then
        local file = io.open( path , "w" )
        file:write(0)
        io.close( file )
        composer.removeScene( "gameTop10", false )
        composer.removeScene( "menu", false )
        composer.gotoScene( "menu")--, { effect = "crossFade", time = 333 } )
    end
end
--
-- Button handler to go to the selected level
--
local function handleLevelSelect( event )
    if ( "ended" == event.phase ) then
        myData.settings.currentLevel = event.target.id
        composer.removeScene( "gameTop10", false )
        composer.gotoScene( "gameTop10")
    end
end
--
-- Start the composer event handlers
--
function scene:create( event )
    local sceneGroup = self.view
    --
    -- create your background here
    --
    display.setDefault( "background", 255,255,255 )
    
    --
    -- Use a widget.newScrollView to contain all the level button objects so you can support more than 
    -- a screen full of them.  Since this will only scroll vertically, lock the horizontal scrolling.
    --



    local endText = display.newText( "Game Over", 0, 0, "RT", 55 )
    endText:setFillColor( 0,0,0 )
    endText.x = display.contentCenterX
    endText.y = display.contentCenterY - 225
    sceneGroup:insert (endText) 
    --
    -- Create a cancel button to give the player a chance to go back to your menu scene.
    --
    local scorePrompt = display.newText( "Final Score:", 0,0, "RT", 20 )
    scorePrompt:setFillColor( 0,0,0 )
    scorePrompt.x = display.contentCenterX
    scorePrompt.y = display.contentCenterY - 165
    sceneGroup:insert(scorePrompt)

    local scoreDisplay = display.newText( tappingSpeed , 0, 0, native.systemFontBold, 80 )
    scoreDisplay:setFillColor(0,0,0)
    scoreDisplay.x = display.contentCenterX
    scoreDisplay.y = display.contentCenterY - 112
    sceneGroup:insert(scoreDisplay)

    local scoreDisplayMS = display.newText( "ms/tap" , 0, 0, native.systemFontBold, 20 )
    scoreDisplayMS:setFillColor(0,0,0)
    scoreDisplayMS.x = display.contentCenterX
    scoreDisplayMS.y = display.contentCenterY - 72
    sceneGroup:insert(scoreDisplayMS)

    local restartButton = widget.newButton
    {
    width = 150,
    height = 150,
    label = "Restart",
    labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255, 0.4 } },
    labelYOffset = -5,
    font = "RT",
    emboss = false,
    fontSize = 24,
    defaultFile = "blueButton.png",
    overFile = "blueButtonPressed.png",
    onRelease = handleLevelSelect,
}
    restartButton.x = display.contentCenterX
    restartButton.y = display.contentCenterY + 25
    sceneGroup:insert(restartButton)

    local menuButton = widget.newButton
        {
        width = 100,
        height = 100,
        label = "Quit",
        labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255, 0.4 } },
        font = "RT",
        emboss = false,
        fontSize = 16,
        labelYOffset = -1,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onRelease = handleCancelButtonEvent,
    }
    menuButton.x = display.contentCenterX
    menuButton.y = display.contentCenterY + 200
    sceneGroup:insert(menuButton)
end
--
function scene:show( event )
    local sceneGroup = self.view
    --
    if event.phase == "did" then
    end
end
--
function scene:hide( event )
    local sceneGroup = self.view
    --
    if event.phase == "will" then
    end
end
--
function scene:destroy( event )
    local sceneGroup = self.view   
end
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
