local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget")
--
-- My "global" like data table, see http://coronalabs.com/blog/2013/05/28/tutorial-goodbye-globals/
--
-- This will contain relevent data for tracking the current level, max levels, number of stars earned
-- per level and score per level (Not used in this tutorial) as well as other settings
----
-- Use a vector star for demo purposes, you probably would want a graphic for this.  Math courtesy of:
-- http://www.smiffysplace.com/stars.html

-- Button handler to cancel the level selection and return to the menu
--
native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )



local function handleCancelButtonEvent( event )
    if ( "ended" == event.phase ) then
        composer.removeScene( "menu", false )
        composer.gotoScene( "menu", { effect = "slideRight", time = 333 } )
    end
end
--
-- Button handler to go to the selected level
--
local function handleLevelSelect( event )
    if ( "ended" == event.phase ) then
        composer.removeScene( "game", false )
        composer.gotoScene( "game", { effect = "slideRight", time = 333} )
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
    native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
    
    display.setDefault( "background", 255,255,255 )
       
    --[[local endText = display.newText( "Credits", 0, 0, "RT", 45 ) --45
    endText:setFillColor( 0,0,0 )
    endText.x = display.contentCenterX
    endText.y = display.contentCenterY - 245
    sceneGroup:insert (endText)--]] 
    --
    -- Create a cancel button to give the player a chance to go back to your menu scene.
    --
    local scorePrompt = display.newText( "Developed and Designed By", 0,0, "HelveticaNeue-Thin", 20 ) --20
    scorePrompt:setFillColor( 0,0,0 )
    scorePrompt.x = display.contentCenterX
    scorePrompt.y = display.contentCenterY - 70
    sceneGroup:insert(scorePrompt)

    local scoreDisplay = display.newText( "Perfect Corner", 0, 0, native.systemFont, 45 ) --80
    scoreDisplay:setFillColor(0,0,0)
    scoreDisplay.x = display.contentCenterX
    scoreDisplay.y = display.contentCenterY - 35
    sceneGroup:insert(scoreDisplay)

    local highscorePrompt = display.newText( "Music Licensed Under Creative Commons", 0, 0, "HelveticaNeue-Thin", 16 ) --16
    highscorePrompt:setFillColor(0,0,0)
    highscorePrompt.x = display.contentCenterX 
    highscorePrompt.y = display.contentCenterY  
    sceneGroup:insert(highscorePrompt)

    local rivalscorePrompt = display.newText( "Stane Stane", 0, 0, native.systemFont, 16 ) --16
    rivalscorePrompt:setFillColor(0,0,0)
    rivalscorePrompt.x = display.contentCenterX 
    rivalscorePrompt.y = display.contentCenterY + 20
    sceneGroup:insert(rivalscorePrompt)

    local CCCredits = display.newText( "GreenhourGlass", 0, 0, native.systemFont, 16 ) --16
    CCCredits:setFillColor(0,0,0)
    CCCredits.x = display.contentCenterX 
    CCCredits.y = display.contentCenterY + 40
    sceneGroup:insert(CCCredits)

    local CCCredits2 = display.newText( "freesounds.org", 0, 0, native.systemFont, 16 ) --16
    CCCredits2:setFillColor(0,0,0)
    CCCredits2.x = display.contentCenterX 
    CCCredits2.y = display.contentCenterY + 60
    sceneGroup:insert(CCCredits2)

    --[[local highscoreDisplay = display.newText( "hello", 0, 0, native.systemFontBold, 50 ) --62
    highscoreDisplay:setFillColor(0,0,0)
    highscoreDisplay.x = display.contentCenterX 
    highscoreDisplay.y = display.contentCenterY
    sceneGroup:insert(highscoreDisplay)]]--
    
    --[[function RivalLoader (event)
        local rivalscoreDisplay = display.newText( rivalScore7, 0, 0, native.systemFontBold, 62 )
        rivalscoreDisplay:setFillColor(0,0,0)
        rivalscoreDisplay.x = display.contentCenterX + 75
        rivalscoreDisplay.y = display.contentCenterY - 50
        sceneGroup:insert(rivalscoreDisplay)
    end]]--

    --timer.performWithDelay( 1000, RivalLoader , 1 )

    local menuButton = widget.newButton
        {
        width = 100,
        height = 100,
        label = "Back",
        labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255, 0.4 } },
        font = "HelveticaNeue-Thin",
        emboss = false,
        fontSize = 16,
        labelYOffset = -1,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onRelease = handleCancelButtonEvent,
    }
    menuButton.x = display.contentCenterX
    menuButton.y = display.contentCenterY + 225
    sceneGroup:insert(menuButton)

    local function systemEvents( event )
       print("systemEvent " .. event.type)
       if ( event.type == "applicationSuspend" ) then
          print( "suspending..........................." )
       elseif ( event.type == "applicationResume" ) then
          print( "resuming............................." )
          native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
       elseif ( event.type == "applicationExit" ) then
          print( "exiting.............................." )
       elseif ( event.type == "applicationStart" ) then
          native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )
       end
       return true
    end

    Runtime:addEventListener( "system", systemEvents )

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
