local composer = require( "composer" )
local scene = composer.newScene()
local widget = require("widget")
local screenW, screenH = display.contentWidth, display.contentHeight
function scene:create( event )
    sceneGroup = self.view
  	native.setProperty( "androidSystemUiVisibility", "immersiveSticky" ) 

    
    secondImg = widget.newButton {
  		width = screenW,
    	height = screenH,
    	defaultFile = "startslide2.png",
        onRelease = menu
    }
    secondImg.x = display.contentCenterX
    secondImg.y = display.contentCenterY
    sceneGroup:insert(secondImg)
    secondImg:setEnabled(true)
    
    firstImg = widget.newButton {
  		width = screenW,
    	height = screenH,
    	defaultFile = "startslide1.png",
        isEnabled = true,
        onRelease = changeImg
    }
    firstImg.x = display.contentCenterX
    firstImg.y = display.contentCenterY
    firstImg:setEnabled(true)
    sceneGroup:insert(firstImg)
    
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

function menu(event)
    composer.gotoScene("settings") 
end

function changeImg( event ) 
	sceneGroup:remove(firstImg)
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

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
return scene
