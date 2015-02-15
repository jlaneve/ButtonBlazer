local composer = require( "composer" )
local scene = composer.newScene()
 

local widget = require("widget")
startSound = audio.loadSound( "gameStart.ogg" )
function startGame ( event )
  if ("event.phase == ended") then
    audio.play( startSound )
    composer.gotoScene("game", {effect = "slideLeft", time = 333} )
  end
end

function startGameTop10 ( event )
  if ("event.phase == ended") then
    audio.play( startSound )
    composer.gotoScene("gameTop10")
  end
end

function scene:create( event )
  local sceneGroup = self.view
    
  display.setDefault( "background", 255,255,255 )

  local startingButton = widget.newButton
  {
    width = 140,
    height = 140,
    label = "Classic",
    emboss = false,
    font = "RT",
    fontSize = 21,
    labelYOffset = -4,
    labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255, 0.4 } },
    defaultFile = "blueButton.png",
    overFile = "blueButtonPressed.png",
    onRelease = startGame,
  }
    startingButton.x = display.contentCenterX 
    startingButton.y = display.contentCenterY - 145
    sceneGroup:insert(startingButton)

  local startingButtonTop10 = widget.newButton
  {
    width = 140,
    height = 140,
    label = "10 Tap Frenzy",
    emboss = false,
    font = "RT",
    fontSize = 21,
    labelYOffset = -4,
    labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255, 0.4 } },
    defaultFile = "blueButton.png",
    overFile = "blueButtonPressed.png",
    onRelease = startGameTop10,
  }
    startingButtonTop10.x = display.contentCenterX 
    startingButtonTop10.y = display.contentCenterY 
    sceneGroup:insert(startingButtonTop10)
   
  local startingButton60Sec = widget.newButton
  {
    width = 140,
    height = 140,
    label = "Coming Soon",
    emboss = false,
    font = "RT",
    fontSize = 21,
    labelYOffset = -4,
    labelColor = { default={ 255, 255, 255 }, over={ 255, 255, 255, 0.4 } },
    defaultFile = "whiteButton.png",
  }
    startingButton60Sec.x = display.contentCenterX 
    startingButton60Sec.y = display.contentCenterY + 145
    sceneGroup:insert(startingButton60Sec) 

   -- Initialize the scene here.
   -- Example: add display objects to "sceneGroup", add touch listeners, etc.
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

