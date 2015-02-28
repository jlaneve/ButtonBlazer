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

colorblind = 3


--
-- Button handler to go to the selected level
--
local function handleLevelSelect( event )
    if ( "ended" == event.phase ) then
        local path = system.pathForFile( "colorblind.txt", system.DocumentsDirectory )
        local file = io.open(path)
        file:write(0)
        file:close()
        composer.removeScene( "menu", false )
        composer.gotoScene( "menu", { effect = "slideRight", time = 333} )
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

    colorblindtext = display.newText( "Off", 0, 0, "RT", 20 ) --45
    colorblindtext:setFillColor( 0,0,0 )
    colorblindtext.x = display.contentCenterX + 100
    colorblindtext.y = display.contentCenterY - 230



    function handleCancelButtonEvent( event )
        if ( "ended" == event.phase ) then
            local colorblindpath = system.pathForFile( "colorblind.txt", system.DocumentsDirectory )
            local colorblindvalue = io.open(colorblindpath)
               if colorblindvalue then
                   print( "File is here" )
                   local path = system.pathForFile( "colorblind.txt", system.DocumentsDirectory )
                   local file = io.open( path , "r" )
                   colorblind = file:read("*n")
                   io.close( file )
                   file = nil
                   colorblindvalue:close( )
                    if colorblind == 1 then
                      local path = system.pathForFile( "colorblind.txt", system.DocumentsDirectory )
                      local file = io.open( path , "w" )
                      file:write (0)
                      io.close( file )
                      file = nil
                      colorblindtext.text = "Off"
                      print("colorblind was disabled")
                    elseif colorblind == 0 then
                      local path = system.pathForFile( "colorblind.txt", system.DocumentsDirectory )
                      local file = io.open( path , "w" )
                      file:write (1)
                      io.close( file )
                      file = nil
                      colorblindtext.text = "On"
                      print( "colorblind was enabled" )
                    end 
               else
                   print( "file does not exist, however this script works" )
                   print( "colorblindenabled" )
                           local path = system.pathForFile( "colorblind.txt" , system.DocumentsDirectory )
                           local file = io.open( path , "w" )
                           file:write( 1 )
                           io.close( file )
                           file = nil
                           colorblindtext.text = "On"
                           --menuButton:setLabel( "On" )

               end
        end
    end

    local endText = display.newText( "Color Blind Support", 0, 0, "RT", 20 ) --45
    endText:setFillColor( 0,0,0 )
    endText.x = display.contentCenterX - 50
    endText.y = display.contentCenterY - 230
    sceneGroup:insert (endText) 
    --
    -- Create a cancel button to give the player a chance to go back to your menu scene.
    --
    --[[local scorePrompt = display.newText( "Developed and Designed By:", 0,0, "RT", 20 ) --20
    scorePrompt:setFillColor( 0,0,0 )
    scorePrompt.x = display.contentCenterX
    scorePrompt.y = display.contentCenterY - 200
    sceneGroup:insert(scorePrompt)

    local scoreDisplay = display.newText( "Samarth Desai", 0, 0, native.systemFontBold, 95 ) --80
    scoreDisplay:setFillColor(0,0,0)
    scoreDisplay.x = display.contentCenterX
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

    local highscoreDisplay = display.newText( "hello", 0, 0, native.systemFontBold, 50 ) --62
    highscoreDisplay:setFillColor(0,0,0)
    highscoreDisplay.x = display.contentCenterX - 75
    highscoreDisplay.y = display.contentCenterY - 50
    sceneGroup:insert(highscoreDisplay)]]--
    
    --[[function RivalLoader (event)
        local rivalscoreDisplay = display.newText( rivalScore7, 0, 0, native.systemFontBold, 62 )
        rivalscoreDisplay:setFillColor(0,0,0)
        rivalscoreDisplay.x = display.contentCenterX + 75
        rivalscoreDisplay.y = display.contentCenterY - 50
        sceneGroup:insert(rivalscoreDisplay)
    end]]--

    --timer.performWithDelay( 1000, RivalLoader , 1 )

    local colorblindbutton = widget.newButton
        {
        width = 50,
        height = 50,
        font = "RT",
        emboss = false,
        color = black,
        fontSize = 16,
        labelYOffset = -1,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onRelease = handleCancelButtonEvent,
    }
    colorblindbutton.x = display.contentCenterX + 100
    colorblindbutton.y = display.contentCenterY - 230
    sceneGroup:insert(colorblindbutton)
    sceneGroup:insert(colorblindtext)

    local menuButton = widget.newButton
        {
        width = 100,
        height = 100,
        label = "Back",
        font = "RT",
        emboss = false,
        fontSize = 16,
        labelYOffset = -1,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onRelease = handleLevelSelect,
    }
    menuButton.x = display.contentCenterX 
    menuButton.y = display.contentCenterY + 220
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
