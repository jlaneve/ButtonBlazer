local composer = require( "composer" )
local scene = composer.newScene()
local gameNetwork = require "gameNetwork"
local widget = require( "widget" )
gameNetwork.init("google")
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
        localPlayerScore = { category="CgkIxO2WsIoUEAIQBg", value=scoreSaved },
    }
)


function achievementChecker( event )
    print( "achievement set" )
end
if scoreSaved >= 5 then
    gameNetwork.request( "unlockAchievement",{achievement ={identifier = "CgkIxO2WsIoUEAIQAQ"},listener = achievementChecker})
end
if scoreSaved >= 10 then
    gameNetwork.request( "unlockAchievement",{achievement ={identifier = "CgkIxO2WsIoUEAIQAg"},listener = achievementChecker})
end
if scoreSaved >= 20 then
    gameNetwork.request( "unlockAchievement",{achievement ={identifier = "CgkIxO2WsIoUEAIQAw"},listener = achievementChecker})
end
if scoreSaved >= 30 then
    gameNetwork.request( "unlockAchievement",{achievement ={identifier = "CgkIxO2WsIoUEAIQBA "},listener = achievementChecker})
end
if scoreSaved >= 40 then
    gameNetwork.request( "unlockAchievement",{achievement ={identifier = "CgkIxO2WsIoUEAIQBQ"},listener = achievementChecker})
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
            

            
        function retrieveRivalAlias (event)
            if (event.type == "loadPlayers") then
                print(event.data[1].alias)
                --[[poopshoot = event.data[1].alias
                rivalAliasDisplay = display.newText( poopshoot, 0, 0, native.systemFontBold, 62 )
                rivalAliasDisplay:setFillColor(0,0,0)
                rivalAliasDisplay.x = display.contentCenterX 
                rivalAliasDisplay.y = display.contentCenterY - 50
                sceneGroup:insert(rivalAliasDisplay)]]--
            end
        end

                LoadingDisplay = display.newText( "Loading...", 0, 0, native.systemFontBold, 25  )
                LoadingDisplay:setFillColor(0,0,0)
                LoadingDisplay.x = display.contentCenterX + 75
                LoadingDisplay.y = display.contentCenterY - 50
                sceneGroup:insert(LoadingDisplay)

        function requestCallback( event )
            if ( event.type == "loadScores" ) then
                rivalScore = event.data[1].value
                rivalID = event.data[1].playerID
                counters = 0
                print(rivalID)
                --gameNetwork.request ("loadPlayers",{playerIDs = {rivalID},listener = retrieveRivalAlias})
            end
        end


        if counters == 0 then
            print ("it is working")
            LoadingDisplay.isVisible = false
            rivalscoreDisplay = display.newText( rivalScore, 0, 0, native.systemFontBold, 50 )
            rivalscoreDisplay:setFillColor(0,0,0)
            rivalscoreDisplay.x = display.contentCenterX + 75
            rivalscoreDisplay.y = display.contentCenterY - 50
            sceneGroup:insert(rivalscoreDisplay)
            counters = nil
        end



        local function scoreretriever ( event )
            gameNetwork.request( "loadScores",
                {
                    leaderboard =
                    {
                        category = "CgkIxO2WsIoUEAIQBg",
                        playerScope = "FriendsOnly",   -- Global, FriendsOnly
                        timeScope = "AllTime",    -- AllTime, Week, Today
                        range = { 1,3 },
                        playerCentered = true
                    },
                    listener = requestCallback
                }
                )
        end


    if gameNetwork.request("isConnected") then 
        timer.performWithDelay( 1, scoreretriever , 1 )
    else
        rivalscoreDisplayOffline = display.newText( highScore, 0, 0, native.systemFontBold, 50 )
        rivalscoreDisplayOffline:setFillColor(0,0,0)
        rivalscoreDisplayOffline.x = display.contentCenterX + 75
        rivalscoreDisplayOffline.y = display.contentCenterY - 50
        sceneGroup:insert(rivalscoreDisplayOffline)
        LoadingDisplay.isVisible = false
    end


    local function handleCancelButtonEvent( event )
        if ( "ended == event.phase" ) then
            if gameNetwork.request("isConnected") then 
                composer.removeScene( "menu", false )
                composer.gotoScene( "menu", { effect = "slideRight", time = 333 } )
                rivalscoreDisplay:removeSelf()
                rivalscoreDisplay = nil
                print( "rival score removal is functioning" )
            else
                composer.removeScene( "menu", false )
                composer.gotoScene( "menu", { effect = "slideRight", time = 333 } )
                rivalscoreDisplayOffline:removeSelf()
                rivalscoreDisplayOffline = nil
                print("remove function is working correctly")
            end
        end
    end
--
-- Button handler to go to the selected level
--
    local function handleLevelSelect( event )
        if ( "ended == event.phase" ) then
            if gameNetwork.request("isConnected") then 
                composer.removeScene( "game", false )
                composer.gotoScene( "game", { effect = "slideRight", time = 333 } )
                rivalscoreDisplay:removeSelf()
                rivalscoreDisplay = nil
                print( "rival score removal is functioning" )
            else
                composer.removeScene( "menu", false )
                composer.gotoScene( "game", { effect = "slideRight", time = 333 } )
                rivalscoreDisplayOffline:removeSelf()
                rivalscoreDisplayOffline = nil
                print("remove function is working correctly")
            end
        end
    end
    --
    -- Use a widget.newScrollView to contain all the level button objects so you can support more than 
    -- a screen full of them.  Since this will only scroll vertically, lock the horizontal scrolling.
    --

    --rivalScore6 = "test"


    local endText = display.newText( "Game Over", 0, 0, "RT", 45 ) --45
    endText:setFillColor( 0,0,0 )
    endText.x = display.contentCenterX
    endText.y = display.contentCenterY - 250
    sceneGroup:insert (endText) 
    --
    -- Create a cancel button to give the player a chance to go back to your menu scene.
    --
    local scorePrompt = display.newText( "Final Score", 0,0, "RT", 20 ) --20
    scorePrompt:setFillColor( 0,0,0 )
    scorePrompt.x = display.contentCenterX
    scorePrompt.y = display.contentCenterY - 200
    sceneGroup:insert(scorePrompt)

    local scoreDisplay = display.newText( scoreSaved, 0, 0, native.systemFontBold, 95 ) --80
    scoreDisplay:setFillColor(0,0,0)
    scoreDisplay.x = display.contentCenterX - 4
    scoreDisplay.y = display.contentCenterY - 145
    sceneGroup:insert(scoreDisplay)

    local highscorePrompt = display.newText( "High Score", 0, 0, "RT", 16 ) --16
    highscorePrompt:setFillColor(0,0,0)
    highscorePrompt.x = display.contentCenterX - 75
    highscorePrompt.y = display.contentCenterY - 90
    sceneGroup:insert(highscorePrompt)

    local rivalscorePrompt = display.newText( "Rival's Score", 0, 0, "RT", 16 ) --16
    rivalscorePrompt:setFillColor(0,0,0)
    rivalscorePrompt.x = display.contentCenterX + 75
    rivalscorePrompt.y = display.contentCenterY - 90
    sceneGroup:insert(rivalscorePrompt)

    local highscoreDisplay = display.newText( highScore, 0, 0, native.systemFontBold, 50 ) --62
    highscoreDisplay:setFillColor(0,0,0)
    highscoreDisplay.x = display.contentCenterX - 75
    highscoreDisplay.y = display.contentCenterY - 50
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
    font = "RT",
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
        font = "RT",
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
