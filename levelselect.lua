local composer = require( "composer" )
local scene = composer.newScene()
local gameNetwork = require "gameNetwork"
local widget = require( "widget" )
gameNetwork.init("gamecenter")
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

local path = system.pathForFile( "score.txt", system.DocumentsDirectory )
local file = io.open( path , "r" )
scoreSaved = file:read("*n")
io.close( file )
file = nil

local path = system.pathForFile( "highscore.txt", system.DocumentsDirectory )
local file = io.open( path , "r" )
local highScore = file:read("*n")
io.close( file )
file = nil



gameNetwork.request( "setHighScore",
    {
        localPlayerScore = { category="Butt0nBl2z3r_HighScores", value=scoreSaved },
    }
)


function achievementChecker( event )
    print( "achievement set" )
end
if scoreSaved >= 5 then
    gameNetwork.request( "unlockAchievement",{achievement ={identifier = "high5"},listener = achievementChecker})
end
if scoreSaved >= 10 then
    gameNetwork.request( "unlockAchievement",{achievement ={identifier = "high10"},listener = achievementChecker})
end
if scoreSaved >= 20 then
    gameNetwork.request( "unlockAchievement",{achievement ={identifier = "high20"},listener = achievementChecker})
end
if scoreSaved >= 30 then
    gameNetwork.request( "unlockAchievement",{achievement ={identifier = "high30"},listener = achievementChecker})
end
if scoreSaved >= 40 then
    gameNetwork.request( "unlockAchievement",{achievement ={identifier = "high40"},listener = achievementChecker})
end
if scoreSaved >= 50 then
    gameNetwork.request( "unlockAchievement",{achievement ={identifier = "high50"},listener = achievementChecker})
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



    local function handleCancelButtonEvent( event )
        if ( "ended == event.phase" ) then
                composer.removeScene( "menu", false )
                composer.gotoScene( "menu", { effect = "slideRight", time = 333 } )
        end
    end
--
-- Button handler to go to the selected level
--
    local function handleLevelSelect( event )
        if ( "ended == event.phase" ) then 
                composer.removeScene( "game", false )
                composer.gotoScene( "game", { effect = "slideRight", time = 333 } )
                print( "rival score removal is functioning" )
        end
    end
    --
    -- Use a widget.newScrollView to contain all the level button objects so you can support more than 
    -- a screen full of them.  Since this will only scroll vertically, lock the horizontal scrolling.
    --

    --rivalScore6 = "test"


    local endText = display.newText( "Game Over", 0, 0, "HelveticaNeue-Thin", 55 ) --45
    endText:setFillColor( 0,0,0 )
    endText.x = display.contentCenterX
    endText.y = display.contentCenterY - 245
    sceneGroup:insert (endText) 
    --
    -- Create a cancel button to give the player a chance to go back to your menu scene.
    --
    local scorePrompt = display.newText( "Final Score", 0,0, "HelveticaNeue-Thin", 20 ) --20
    scorePrompt:setFillColor( 0,0,0 )
    scorePrompt.x = display.contentCenterX
    scorePrompt.y = display.contentCenterY - 200
    sceneGroup:insert(scorePrompt)

    local scoreDisplay = display.newText( scoreSaved, 0, 0, native.systemFont, 95 ) --80
    scoreDisplay:setFillColor(0,0,0)
    scoreDisplay.x = display.contentCenterX - 1
    scoreDisplay.y = display.contentCenterY - 145
    sceneGroup:insert(scoreDisplay)

    local highscorePrompt = display.newText( "High Score", 0, 0, "HelveticaNeue-Thin", 16 ) --16
    highscorePrompt:setFillColor(0,0,0)
    highscorePrompt.x = display.contentCenterX 
    highscorePrompt.y = display.contentCenterY - 80
    sceneGroup:insert(highscorePrompt)

    local highscoreDisplay = display.newText( highScore, 0, 0, native.systemFont, 50 ) --62
    highscoreDisplay:setFillColor(0,0,0)
    highscoreDisplay.x = display.contentCenterX - 2 
    highscoreDisplay.y = display.contentCenterY - 40
    sceneGroup:insert(highscoreDisplay)
    
    --[[function RivalLoader (event)
        local rivalscoreDisplay = display.newText( rivalScore7, 0, 0, native.systemFontBold, 62 )
        rivalscoreDisplay:setFillColor(0,0,0)
        rivalscoreDisplay.x = display.contentCenterX + 75
        rivalscoreDisplay.y = display.contentCenterY - 50
        sceneGroup:insert(rivalscoreDisplay)
    end]]--

    --timer.performWithDelay( 1000, RivalLoader , 1 )



    local restartButton = widget.newButton
    {
    width = 150,
    height = 150,
    label = "Restart",
    labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255, 0.4 } },
    labelYOffset = -5,
    font = "HelveticaNeue-Thin",
    emboss = false,
    fontSize = 24,
    defaultFile = "blueButton.png",
    overFile = "blueButtonPressed.png",
    onRelease = handleLevelSelect,
}
    restartButton.x = display.contentCenterX
    restartButton.y = display.contentCenterY + 75
    sceneGroup:insert(restartButton)

    local menuButton = widget.newButton
        {
        width = 100,
        height = 100,
        label = "Quit",
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
