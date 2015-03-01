local composer = require( "composer" )
local scene = composer.newScene()
local gameNetwork = require "gameNetwork" 

gameNetwork.init("gamecenter")

--local loggedIntoGC = false


--[[local function initCallback( event )
local function initCallback( event )
    if ( event.type == "showSignIn" ) then
      print("sign in working")
    elseif ( event.data ) then
        loggedIntoGC = true
    end
end

local function onSystemEvent( event ) 
    if ( event.type == "applicationStart" ) then
        gameNetwork.init( "gamecenter", initCallback )
        return true
    end
end
Runtime:addEventListener( "system", onSystemEvent )]]--

local widget = require("widget")
startSound = audio.loadSound( "gameStart.ogg" )

function startGame ( event )
  if ("event.phase == ended") then
    audio.play( startSound )
    composer.gotoScene("game", {effect = "slideLeft", time = 333} )
  end
end

function showHelp ( event )
  if ("event.phase == ended") then
    audio.play( startSound )
    native.showAlert( "How to Play", "Tap the blue squares to gain time and points. Avoid the red!")
  end
end

local function gotoCredits( event )
  if ("event.phase == ended") then
    audio.play( startSound )
    composer.removeScene( "menu", false )
    composer.showOverlay( "appCredit" )
  end
end

local function gotoSettings( event )
  if ("event.phase == ended") then
    audio.play( startSound )
    composer.removeScene( "menu", false )
    composer.gotoScene( "settings" )
  end
end


local function showLeaderboards( event )
  if ("event.phase == ended") then
     gameNetwork.show("leaderboards")
  end
end

native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )

function scene:create( event )
  local sceneGroup = self.view
  native.setProperty( "androidSystemUiVisibility", "immersiveSticky" )  
  display.setDefault( "background", 255,255,255 )

  local startingButton = widget.newButton
  {
    width = 205,
    height = 205,
    label = "Start",
    emboss = false,
    font = "HelveticaNeue-Thin",
    fontSize = 45,
    labelYOffset = -5,
    labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255, 0.4 } },
    defaultFile = "blueButton.png",
    overFile = "blueButtonPressed.png",
    onRelease = startGame,
  }
    startingButton.x = display.contentCenterX
    startingButton.y = display.contentCenterY - 25
    sceneGroup:insert(startingButton)

  local helpButton = widget.newButton
  {
    width = 30,
    height = 30,
    emboss = false,
    font = "HelveticaNeue-Thin",
    fontSize = 45,
    labelYOffset = -5,
    labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255, 0.4 } },
    defaultFile = "helpIcon.png",
    onRelease = showHelp,
  }
    helpButton.x = display.contentCenterX - 145
    helpButton.y = display.contentCenterY + 260
    sceneGroup:insert(helpButton)

  local leaderboardsButton = widget.newButton
  {
    width = 75,
    height = 75,
    defaultFile = "leaderboardsIcon.png",
    onEvent = showLeaderboards,
  }
  leaderboardsButton.x = display.contentCenterX 
  leaderboardsButton.y = display.contentCenterY + 220
  sceneGroup:insert(leaderboardsButton)

  local creditsButton = widget.newButton
  {
    width = 75,
    height = 75,
    defaultFile = "creditsIcon.png",
    onEvent = gotoCredits,
  }
  creditsButton.x = display.contentCenterX + 90
  creditsButton.y = display.contentCenterY + 220
  sceneGroup:insert(creditsButton)

  local settingsButton = widget.newButton
  {
    width = 75,
    height = 75,
    defaultFile = "settingsIcon.png",
    onEvent = gotoSettings,
  }
  settingsButton.x = display.contentCenterX - 90
  settingsButton.y = display.contentCenterY + 220
  sceneGroup:insert(settingsButton)
   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.

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
   
    local titleText = display.newText( "Button Blazer", 0, 0, "HelveticaNeue-Thin", 50 ) --45
    titleText:setFillColor( .01, .66, .95, 1 )
    titleText.x = display.contentCenterX
    titleText.y = display.contentCenterY - 235
    sceneGroup:insert (titleText) 

end



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
-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------

return scene

