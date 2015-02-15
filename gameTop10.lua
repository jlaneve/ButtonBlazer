local composer = require( "composer" )
local scene = composer.newScene()
local widget = require( "widget" )

local params

score = -1

timesTapped = -1

blip1 = audio.loadSound( "blip1.wav" )
blip2 = audio.loadSound( "blip2.wav" )

--local function gameLaunchCounter( ... )
    --gamesLaunched = 0 
    --local path = system.pathForFile( "gamesLaunched.txt", system.DocumentsDirectory )
    --local file = io.open( path, "w" )
    --gamesLaunched = file:write("*a")

--end





display.setDefault( "background", 255,255,255 )
-- Start the composer event handlers
--



function scene:create( event )
    local sceneGroup = self.view

    params = event.params
        
    --make room for BUTTONS GALORE

 -- _____  ______ ______     _    _ _   _______   ____  _    _ _______ _______ ____  _   _  _____ 
 --|  __ \|  ____|  ____/\  | |  | | | |__   __| |  _ \| |  | |__   __|__   __/ __ \| \ | |/ ____|
 --| |  | | |__  | |__ /  \ | |  | | |    | |    | |_) | |  | |  | |     | | | |  | |  \| | (___  
 --| |  | |  __| |  __/ /\ \| |  | | |    | |    |  _ <| |  | |  | |     | | | |  | | . ` |\___ \ 
 --| |__| | |____| | / ____ \ |__| | |____| |    | |_) | |__| |  | |     | | | |__| | |\  |____) |
 --|_____/|______|_|/_/    \_\____/|______|_|    |____/ \____/   |_|     |_|  \____/|_| \_|_____/ 
 --                                                                                             
                                                                                                
--testbutton = widget.newButton
--{
  --shape = "roundedrect",
  --width = 100,
  --height = 50,
  --label = "test",
  --onEvent = newBlue,
--}
--testbutton.x = display.contentCenterX
    
    local scoreTitle = display.newText( "Score", 0, 0, "RT", 20 ) -- displays "Score" at top
    scoreTitle:setFillColor( 0,0,0 )
    scoreTitle.x = display.contentCenterX
    scoreTitle.y = 1
    sceneGroup:insert (scoreTitle)

    local scoreLabel = display.newText( score, 0, 0, native.systemFont, 80 ) -- displays numerical score variable
    scoreLabel:setFillColor( 0,0,0 )
    scoreLabel.x = display.contentCenterX
    scoreLabel.y = 57
    sceneGroup:insert(scoreLabel)

    local timeleftLabel = display.newText("Time",0,0,"RT",20)
    timeleftLabel:setFillColor( 0,0,0 )
    timeleftLabel.x = display.contentCenterX
    timeleftLabel.y = 115 
    sceneGroup:insert(timeleftLabel)
     -- time amount
    local timeDisplay = display.newText("Press Blue to Start",0,0,native.systemFont,36) -- displays time
    timeDisplay:setFillColor( 0,0,0 )
    timeDisplay.x = display.contentCenterX
    timeDisplay.y = 155
    sceneGroup:insert(timeDisplay)
    

    scoreFail = 0 -- value to use when player hits a red square
    
    score = -1
    
    function gameEndTimer (event)
        audio.play( blip2 )
        local path = system.pathForFile( "scoreTimer.txt" , system.DocumentsDirectory )
        local file = io.open( path , "w" )
        file:write( scoreSave )
        io.close( file )
        file = nil
        composer.removeScene( "levelSelectTop10", false )
        composer.removeScene( "gameTop10", false )
        composer.gotoScene( "levelSelectTop10")
      -- body
    end

  


    counter = 0
    local function updateTimer(event) -- actual countdown
        counter = counter + 1
        timeDisplay.text = counter .. "ms"
        if counter == 0 then
        timer.performWithDelay( 1, gameEndTimer , 1)
        print( "this should be printing")
        end
    end

local timer1 = timer.performWithDelay(1, updateTimer, 0)

  function gameEnd( event )
        --, { effect = "crossFade", time = 333 } )
    if ( "ended" == event.phase ) then
        audio.play( blip2 )
        timer.cancel( timer1 )
        local path = system.pathForFile( "scoreTimer.txt" , system.DocumentsDirectory )
        local file = io.open( path , "w" )
        file:write( scoreFail   )
        io.close( file )
        file = nil
        composer.removeScene( "levelSelectTop10", false )
        composer.removeScene( "gameTop10", false )
        composer.gotoScene( "levelSelectTop10")--, { effect = "crossFade", time = 333 } )
    end
    end
    
    function newBlue ( event ) -- chooses new red and blue buttons
      if ("event.phase == ended") then
        timesTapped = timesTapped + 1
        audio.play( blip1)
        timer.cancel( timer1 )
        timer1 = timer.performWithDelay(1, updateTimer, 0) 
        buttonBPick = math.random( 9 )
        buttonRPick = math.random( 9 )
        score = score + 1
        scoreSave = counter
        scoreLabel.text = score
      end
        if score == 10 then 
          timer.cancel( timer1 )
          timer.performWithDelay( 1, gameEndTimer ,1 )
          print( buttonBPick .. "  " .. buttonRPick ) 
      end
      if timesTapped == 0
        then timer.cancel( timer1 )
      end
      --if timer1 then
        --timer.cancel( timer1 )
        --timer1 = timer.performWithDelay(1, updateTimer, 150)
      --end
      if buttonBPick == buttonRPick then
          print( "they are the same" )
          button1R:setEnabled (false)
          button1R.isVisible = false
          button2R:setEnabled (false)
          button2R.isVisible = false
          button3R:setEnabled (false)
          button3R.isVisible = false
          button4R:setEnabled(false)
          button4R.isVisible = false
          button5R:setEnabled( false )
          button5R.isVisible = false
          button6R:setEnabled( false )
          button6R.isVisible = false
          button7R:setEnabled( false )
          button7R.isVisible = false
          button8R:setEnabled (false)
          button8R.isVisible = false
          button9R:setEnabled(false)
          button9R.isVisible = false
        --resetting all blues back 
          button1B:setEnabled (false)
          button1B.isVisible = false
          button2B:setEnabled (false)
          button2B.isVisible = false
          button3B:setEnabled (false)
          button3B.isVisible = false
          button4B:setEnabled(false)
          button4B.isVisible = false
          button5B:setEnabled( false )
          button5B.isVisible = false
          button6B:setEnabled( false )
          button6B.isVisible = false
          button7B:setEnabled( false )
          button7B.isVisible = false
          button8B:setEnabled (false)
          button8B.isVisible = false
          button9B:setEnabled(false)
          button9B.isVisible = false
          button1R:setEnabled (true) -- clears up space for the red button by removing reg and blue
          button1R.isVisible = true
          button1:setEnabled (true)
          button1.isVisible = true
          button1B:setEnabled (false)
          button1B.isVisible = false
          -- Setting up blue button now
          button2R:setEnabled (false)
          button2R.isVisible = false
          button2:setEnabled (true)
          button2.isVisible = true
          button2B:setEnabled (true)
          button2B.isVisible = true
        elseif buttonBPick == 1 then 
          button1R:setEnabled (false) --red is disabled
          button1R.isVisible = false
          button1:setEnabled (true)--default is recreated for future use
          button1.isVisible = true
          button1B:setEnabled (true)--blue is finally drawn
          button1B.isVisible = true
          button2B:setEnabled( false )--currentl a test... 
          button2B.isVisible = false
          button3B:setEnabled( false )
          button3B.isVisible = false
          button4B:setEnabled(false)
          button4B.isVisible = false
          button5B:setEnabled( false )
          button5B.isVisible = false
          button6B:setEnabled (false)
          button6B.isVisible = false
          button7B:setEnabled (false)
          button7B.isVisible = false
          button8B:setEnabled (false)
          button8B.isVisible = false
          button9:setEnabled (false)
          button9B.isVisible = false
        elseif
        buttonBPick == 2 then 
          button2R:setEnabled (false) --red is disabled
          button2R.isVisible = false
          button2:setEnabled (true)--default is recreated for future use
          button2.isVisible = true
          button2B:setEnabled (true)--blue is finally drawn
          button2B.isVisible = true
          button1B:setEnabled( false )--currentl a test... 
          button1B.isVisible = false
          button3B:setEnabled( false )
          button3B.isVisible = false
          button4B:setEnabled(false)
          button4B.isVisible = false
          button5B:setEnabled( false )
          button5B.isVisible = false
          button6B:setEnabled (false)
          button6B.isVisible = false
          button7B:setEnabled (false)
          button7B.isVisible = false
          button8B:setEnabled (false)
          button8B.isVisible = false
          button9:setEnabled (false)
          button9B.isVisible = false
        elseif
         buttonBPick == 3 then 
          button3R:setEnabled (false) --red is disabled
          button3R.isVisible = false
          button3:setEnabled (true)--default is recreated for future use
          button3.isVisible = true
          button3B:setEnabled (true)--blue is finally drawn
          button3B.isVisible = true
          button2B:setEnabled( false )--currentl a test... 
          button2B.isVisible = false
          button1B:setEnabled( false )
          button1B.isVisible = false
          button4B:setEnabled(false)
          button4B.isVisible = false
          button5B:setEnabled( false )
          button5B.isVisible = false
          button6B:setEnabled (false)
          button6B.isVisible = false
          button7B:setEnabled (false)
          button7B.isVisible = false
          button8B:setEnabled (false)
          button8B.isVisible = false
          button9:setEnabled (false)
          button9B.isVisible = false
        elseif
        buttonBPick == 4 then 
          button4R:setEnabled (false) --red is disabled
          button4R.isVisible = false
          button4:setEnabled (true)--default is recreated for future use
          button4.isVisible = true
          button4B:setEnabled (true)--blue is finally drawn
          button4B.isVisible = true
          button2B:setEnabled( false )--currentl a test... 
          button2B.isVisible = false
          button3B:setEnabled( false )
          button3B.isVisible = false
          button1B:setEnabled(false)
          button1B.isVisible = false
          button5B:setEnabled( false )
          button5B.isVisible = false
          button6B:setEnabled (false)
          button6B.isVisible = false
          button7B:setEnabled (false)
          button7B.isVisible = false
          button8B:setEnabled (false)
          button8B.isVisible = false
          button9:setEnabled (false)
          button9B.isVisible = false
        elseif
        buttonBPick == 5 then 
          button5R:setEnabled (false) --red is disabled
          button5R.isVisible = false
          button5:setEnabled (true)--default is recreated for future use
          button5.isVisible = true
          button5B:setEnabled (true)--blue is finally drawn
          button5B.isVisible = true
          button2B:setEnabled( false )--currentl a test... 
          button2B.isVisible = false
          button3B:setEnabled( false )
          button3B.isVisible = false
          button4B:setEnabled(false)
          button4B.isVisible = false
          button1B:setEnabled( false )
          button1B.isVisible = false
          button6B:setEnabled (false)
          button6B.isVisible = false
          button7B:setEnabled (false)
          button7B.isVisible = false
          button8B:setEnabled (false)
          button8B.isVisible = false
          button9:setEnabled (false)
          button9B.isVisible = false
        elseif
        buttonBPick == 6 then 
          button6R:setEnabled (false) --red is disabled
          button6R.isVisible = false
          button6:setEnabled (true)--default is recreated for future use
          button6.isVisible = true
          button6B:setEnabled (true)--blue is finally drawn
          button6B.isVisible = true
          button2B:setEnabled( false )--currentl a test... 
          button2B.isVisible = false
          button3B:setEnabled( false )
          button3B.isVisible = false
          button4B:setEnabled(false)
          button4B.isVisible = false
          button5B:setEnabled( false )
          button5B.isVisible = false
          button1B:setEnabled (false)
          button1B.isVisible = false
          button7B:setEnabled (false)
          button7B.isVisible = false
          button8B:setEnabled (false)
          button8B.isVisible = false
          button9:setEnabled (false)
          button9B.isVisible = false
        elseif
        buttonBPick == 7 then
          button7R:setEnabled (false) --red is disabled
          button7R.isVisible = false
          button7:setEnabled (true)--default is recreated for future use
          button7.isVisible = true
          button7B:setEnabled (true)--blue is finally drawn
          button7B.isVisible = true
          button2B:setEnabled( false )--currentl a test... 
          button2B.isVisible = false
          button3B:setEnabled( false )
          button3B.isVisible = false
          button4B:setEnabled(false)
          button4B.isVisible = false
          button5B:setEnabled( false )
          button5B.isVisible = false
          button6B:setEnabled (false)
          button6B.isVisible = false
          button1B:setEnabled (false)
          button1B.isVisible = false
          button8B:setEnabled (false)
          button8B.isVisible = false
          button9:setEnabled (false)
          button9B.isVisible = false
        elseif
        buttonBPick == 8 then
          button8R:setEnabled (false) --red is disabled
          button8R.isVisible = false
          button8:setEnabled (true)--default is recreated for future use
          button8.isVisible = true
          button8B:setEnabled (true)--blue is finally drawn
          button8B.isVisible = true
          button2B:setEnabled( false )--currentl a test... 
          button2B.isVisible = false
          button3B:setEnabled( false )
          button3B.isVisible = false
          button4B:setEnabled(false)
          button4B.isVisible = false
          button5B:setEnabled( false )
          button5B.isVisible = false
          button6B:setEnabled (false)
          button6B.isVisible = false
          button7B:setEnabled (false)
          button7B.isVisible = false
          button1B:setEnabled (false)
          button1B.isVisible = false
          button9:setEnabled (false)
          button9B.isVisible = false
        elseif
        buttonBPick == 9 then
          button9R:setEnabled (false) --red is disabled
          button9R.isVisible = false
          button9:setEnabled (true)--default is recreated for future use
          button9.isVisible = true
          button9B:setEnabled (true)--blue is finally drawn
          button9B.isVisible = true
          button2B:setEnabled( false )--currentl a test... 
          button2B.isVisible = false
          button3B:setEnabled( false )
          button3B.isVisible = false
          button4B:setEnabled(false)
          button4B.isVisible = false
          button5B:setEnabled( false )
          button5B.isVisible = false
          button6B:setEnabled (false)
          button6B.isVisible = false
          button7B:setEnabled (false)
          button7B.isVisible = false
          button8B:setEnabled (false)
          button8B.isVisible = false
          button1:setEnabled (false)
          button1B.isVisible = false
        end
        --red buttons
        if buttonBPick == buttonRPick then
          print( "they are the same" )
          button1R:setEnabled (false)
          button1R.isVisible = false
          button2R:setEnabled (false)
          button2R.isVisible = false
          button3R:setEnabled (false)
          button3R.isVisible = false
          button4R:setEnabled(false)
          button4R.isVisible = false
          button5R:setEnabled( false )
          button5R.isVisible = false
          button6R:setEnabled( false )
          button6R.isVisible = false
          button7R:setEnabled( false )
          button7R.isVisible = false
          button8R:setEnabled (false)
          button8R.isVisible = false
          button9R:setEnabled(false)
          button9R.isVisible = false
        --resetting all blues back 
          button1B:setEnabled (false)
          button1B.isVisible = false
          button2B:setEnabled (false)
          button2B.isVisible = false
          button3B:setEnabled (false)
          button3B.isVisible = false
          button4B:setEnabled(false)
          button4B.isVisible = false
          button5B:setEnabled( false )
          button5B.isVisible = false
          button6B:setEnabled( false )
          button6B.isVisible = false
          button7B:setEnabled( false )
          button7B.isVisible = false
          button8B:setEnabled (false)
          button8B.isVisible = false
          button9B:setEnabled(false)
          button9B.isVisible = false
          button1R:setEnabled (true) -- clears up space for the red button by removing reg and blue
          button1R.isVisible = true
          button1:setEnabled (true)
          button1.isVisible = true
          button1B:setEnabled (false)
          button1B.isVisible = false
          -- Setting up blue button now
          button2R:setEnabled (false)
          button2R.isVisible = false
          button2:setEnabled (true)
          button2.isVisible = true
          button2B:setEnabled (true)
          button2B.isVisible = true
        elseif buttonRPick == 1 then
          button1R:setEnabled( true )
          button1R.isVisible = true
          button1B:setEnabled(false)
          button1B.isVisible = false
        elseif
        buttonRPick == 2 then
          button2R:setEnabled( true )
          button2R.isVisible = true
          button2B:setEnabled( false )
          button2B.isVisible = false
        elseif
        buttonRPick == 3 then
          button3R:setEnabled( true )
          button3R.isVisible = true
          button3B:setEnabled( false )
          button3B.isVisible = false
        elseif
        buttonRPick == 4 then
          button4R:setEnabled( true )
          button4R.isVisible = true
          button4B:setEnabled (false)
          button4B.isVisible = false
        elseif
        buttonRPick == 5 then
          button5R:setEnabled( true )
          button5R.isVisible = true
          button5B:setEnabled( false )
          button5B.isVisible = false
        elseif
        buttonRPick == 6 then
          button6R:setEnabled( true )
          button6R.isVisible = true
          button6B:setEnabled( false )
          button6B.isVisible = false
        elseif
        buttonRPick == 7 then
          button7R:setEnabled( true )
          button7R.isVisible = true
          button7B:setEnabled( false )
          button7B.isVisible = false
        elseif
        buttonRPick == 8 then
          button8R:setEnabled( true )
          button8R.isVisible = true
          button8B:setEnabled( false )
          button8B.isVisible = false
        elseif
        buttonRPick == 9 then
          button9R:setEnabled( true )
          button9R.isVisible = true
          button9B:setEnabled( false )
          button9B.isVisible = false
        end
    end
    
    timer.performWithDelay( 1, newBlue , 1 )

    


    button1 = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "whiteButton.png",
        onEvent = nil,
    }
    button1.x = display.contentCenterX/3 + 2
    button1.y = display.contentCenterY - 4 
    sceneGroup:insert (button1)

    button2 = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "whiteButton.png",
        onEvent = nil,
    }
    button2.x = display.contentCenterX
    button2.y = display.contentCenterY - 4
    sceneGroup:insert(button2)


    button3 = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "whiteButton.png",
        onEvent = nil,
    }
    button3.x = 4 * display.contentCenterX/3  + 51
    button3.y = display.contentCenterY - 4
    sceneGroup:insert(button3)

    button4 = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "whiteButton.png",
        onEvent = nil,
    }
    button4.x = display.contentCenterX/3 + 2
    button4.y = display.contentCenterY + 103
    sceneGroup:insert(button4)

    button5 = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "whiteButton.png",
        onEvent = nil,
    }
    button5.x = display.contentCenterX
    button5.y = display.contentCenterY + 103
    sceneGroup:insert(button5)

    button6 = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "whiteButton.png",
        onEvent = nil,
    }
    button6.x = 4 * display.contentCenterX/3 + 51
    button6.y = display.contentCenterY + 103
    sceneGroup:insert(button6)


    button7 = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "whiteButton.png",
        onEvent = nil,
    }
    button7.x = display.contentCenterX/3 + 2
    button7.y = display.contentCenterY + 210
    sceneGroup:insert(button7)

    button8 = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "whiteButton.png",
        onEvent = nil,
    }
    button8.x = display.contentCenterX
    button8.y = display.contentCenterY + 210
    sceneGroup:insert(button8)

    button9 = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "whiteButton.png",
        onEvent = nil,
    }
    button9.x = 4 * display.contentCenterX/3 + 51
    button9.y = display.contentCenterY + 210
    sceneGroup:insert(button9)

      --_____  ______ _____    ____  _    _ _______ _______ ____  _   _  _____ 
     --|  __ \|  ____|  __ \  |  _ \| |  | |__   __|__   __/ __ \| \ | |/ ____|
     --| |__) | |__  | |  | | | |_) | |  | |  | |     | | | |  | |  \| | (___  
     --|  _  /|  __| | |  | | |  _ <| |  | |  | |     | | | |  | | . ` |\___ \ 
     --| | \ \| |____| |__| | | |_) | |__| |  | |     | | | |__| | |\  |____) |
     --|_|  \_\______|_____/  |____/ \____/   |_|     |_|  \____/|_| \_|_____/ 
      --

    button1R = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onEvent = gameEnd
    }
    button1R.x = display.contentCenterX/3 + 2
    button1R.y = display.contentCenterY - 4
    button1R:setEnabled( false )
    button1R.isVisible = false
    sceneGroup:insert(button1R)

    button2R = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onEvent = gameEnd,
    }
    button2R.x = display.contentCenterX
    button2R.y = display.contentCenterY - 4
    button2R:setEnabled( false )
    button2R.isVisible = false
    sceneGroup:insert(button2R)

    button3R = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onEvent = gameEnd,
    }
    button3R.x = 4 * display.contentCenterX/3 + 51
    button3R.y = display.contentCenterY - 4
    button3R:setEnabled( false )
    button3R.isVisible = false
    sceneGroup:insert(button3R)

    button4R = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onEvent = gameEnd
    }
    button4R.x = display.contentCenterX/3 + 2
    button4R.y = display.contentCenterY + 103
    button4R:setEnabled( false )
    button4R.isVisible = false
    sceneGroup:insert(button4R)


    button5R = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onEvent = gameEnd,
    }
    button5R.x = display.contentCenterX
    button5R.y = display.contentCenterY + 103
    button5R:setEnabled( false )
    button5R.isVisible = false
    sceneGroup:insert(button5R)


    button6R = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onEvent = gameEnd,
    }
    button6R.x = 4 * display.contentCenterX/3 + 51
    button6R.y = display.contentCenterY + 103
    button6R:setEnabled( false )
    button6R.isVisible = false
    sceneGroup:insert(button6R)

    button7R = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onEvent = gameEnd
    }
    button7R.x = display.contentCenterX/3 + 2
    button7R.y = display.contentCenterY + 210
    button7R:setEnabled( false )
    button7R.isVisible = false
    sceneGroup:insert(button7R)


    button8R = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onEvent = gameEnd,
    }
    button8R.x = display.contentCenterX
    button8R.y = display.contentCenterY + 210
    button8R:setEnabled( false )
    button8R.isVisible = false
    sceneGroup:insert(button8R)

    button9R = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "redButton.png",
        overFile = "redButtonPressed.png",
        onEvent = gameEnd,
    }
    button9R.x = 4 * display.contentCenterX/3 + 51
    button9R.y = display.contentCenterY + 210
    button9R:setEnabled( false )
    button9R.isVisible = false
    sceneGroup:insert(button9R)

    --  ____  _     _    _ ______   ____  _    _ _______ _______ ____  _   _  _____ 
    -- |  _ \| |   | |  | |  ____| |  _ \| |  | |__   __|__   __/ __ \| \ | |/ ____|
     --| |_) | |   | |  | | |__    | |_) | |  | |  | |     | | | |  | |  \| | (___  
     --|  _ <| |   | |  | |  __|   |  _ <| |  | |  | |     | | | |  | | . ` |\___ \ 
     --| |_) | |___| |__| | |____  | |_) | |__| |  | |     | | | |__| | |\  |____) |
     --|____/|______\____/|______| |____/ \____/   |_|     |_|  \____/|_| \_|_____/ 
    --                                                                            
    --

    button1B = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "blueButton.png",
        overFile = "blueButtonPressed.png",
        onRelease = newBlue,
    }
    button1B.x = display.contentCenterX/3 + 2
    button1B.y = display.contentCenterY - 4
    button1B:setEnabled( false )
    button1B.isVisible = false
    sceneGroup:insert(button1B)
    --button1B:addEventListener( "tap", button1Bdisable )

    button2B = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "blueButton.png",
        overFile = "blueButtonPressed.png",
        onRelease = newBlue,
    }
    button2B.x = display.contentCenterX
    button2B.y = display.contentCenterY - 4
    button2B:setEnabled( false )
    button2B.isVisible = false
    --button2B:addEventListener( "tap", button2Bdisable )
    sceneGroup:insert(button2B)

    button3B = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "blueButton.png",
        overFile = "blueButtonPressed.png",
        onRelease = newBlue,
    }
    button3B.x = 4 * display.contentCenterX/3 + 51
    button3B.y = display.contentCenterY - 4
    button3B:setEnabled( false )
    button3B.isVisible = false
    --button3B:addEventListener( "tap", button3Bdisable )
    sceneGroup:insert(button3B)

    button4B = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "blueButton.png",
        overFile = "blueButtonPressed.png",
        onRelease = newBlue,
    }
    button4B.x = display.contentCenterX/3 + 2
    button4B.y = display.contentCenterY + 103
    button4B:setEnabled( false )
    button4B.isVisible = false
    --button4B:addEventListener( "tap", button4Bdisable )
    sceneGroup:insert(button4B)

    button5B = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "blueButton.png",
        overFile = "blueButtonPressed.png",
        onRelease = newBlue,
    }
    button5B.x = display.contentCenterX
    button5B.y = display.contentCenterY + 103
    button5B:setEnabled( false )
    button5B.isVisible = false
    --button5B:addEventListener( "tap", button5Bdisable )
    sceneGroup:insert(button5B)

    button6B = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "blueButton.png",
        overFile = "blueButtonPressed.png",
        onRelease = newBlue,
    }
    button6B.x = 4 * display.contentCenterX/3 + 51
    button6B.y = display.contentCenterY + 103
    button6B:setEnabled( false )
    button6B.isVisible = false
    --button6B:addEventListener( "tap", button6Bdisable )
    sceneGroup:insert(button6B)

    button7B = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "blueButton.png",
        overFile = "blueButtonPressed.png",
        onRelease = newBlue,
    }
    button7B.x = display.contentCenterX/3 + 2
    button7B.y = display.contentCenterY + 210
    button7B:setEnabled( false )
    button7B.isVisible = false
    --button7B:addEventListener( "tap", button7Bdisable )
    sceneGroup:insert(button7B)

    button8B = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "blueButton.png",
        overFile = "blueButtonPressed.png",
        onRelease = newBlue,
    }
    button8B.x = display.contentCenterX
    button8B.y = display.contentCenterY + 210
    button8B:setEnabled( false )
    button8B.isVisible = false
    --button8B:addEventListener( "tap", button8Bdisable )
    sceneGroup:insert(button8B)

    button9B = widget.newButton
    {
        width = 100,
        height = 100,
        defaultFile = "blueButton.png",
        overFile = "blueButtonPressed.png",
        onRelease = newBlue,
    }
    button9B.x = 4 * display.contentCenterX/3 + 51
    button9B.y = display.contentCenterY + 210
    button9B:setEnabled( false )
    button9B.isVisible = false
    sceneGroup:insert(button9B)
    --button9B:addEventListener( "tap", button9Bdisable )--
        -- setup a page background, really not that important though composer
        -- crashes out if there isn't a display object in the view.
    --
    --
end

function scene:show( event )
    local sceneGroup = self.view

    params = event.params

    if event.phase == "did" then
    end
end

function scene:hide( event )
    local sceneGroup = self.view
    
    if event.phase == "will" then
    end

end

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
