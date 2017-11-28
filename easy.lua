widget = require("widget")
require("soundFiles")

local storyboard = require "storyboard"
local scene = storyboard.newScene()
centerX = display.contentWidth / 2
centerY = display.contentHeight / 2

display.setStatusBar( display.HiddenStatusBar )

system.activate("multitouch")

local topY = display.screenOriginY --Numerical value for the top of the screen
local rightX = display.contentWidth - display.screenOriginX --Numerical value for the right of the screen
local bottomY = display.contentHeight - display.screenOriginY --Numerical value for the bottom of the screen
local leftX = display.screenOriginX --Numerical value for the left of the screen
local screenW = rightX - leftX --Numerical value for the width of the screen
local screenH = bottomY - topY --Numerical value for the height of the screen
local background = display.newImageRect( "background.png", 600, 330)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
local barbedwireleft = display.newImageRect( "barbedwireleft.png", 110, 370)
  barbedwireleft.x = display.contentCenterX/20
  barbedwireleft.y = display.contentCenterY-5
local barbedwireright = display.newImageRect( "barbedwireright.png", 110, 370)
  barbedwireright.x = display.contentCenterX+270
  barbedwireright.y = display.contentCenterY+6

    local object1 = widget.newButton{
    width = 30,
    height = 30,
    defaultFile = "back.png",
    overFile = "back_down.png",
    }
   object1:addEventListener( "tap", object1 )
   object1.x = centerX
    object1.y = centerY - 125
function object1:tap( event )
    playSFX(audioclick)  

    resetBall()
    resetPlayers()
    resetScore()
    resetSpeed()
    storyboard.removeScene("multiplayer")


    storyboard.gotoScene ("vscpu", { effect = "zoomOutIn"})
end



local function onUpdate( event )

end

function scene:createScene( event )
   local group = self.view

    group:insert( background)
    group:insert( barbedwireright)
    group:insert( barbedwireleft)
    group:insert( player1)
    group:insert( player2)
    group:insert( ball)
    group:insert( topLine)
    group:insert( bottomLine)
    group:insert( middleLine)
    group:insert( option3)
    group:insert( option4)
    group:insert( textScore1)
    group:insert( textScore2)
    group:insert( object1)
    resetBall()

end
scene:addEventListener( "createScene", scene )

function scene:willEnterScene( event )
   background.isVisible = false
   barbedwireright.isVisible = false
   barbedwireleft.isVisible = false
   player1.isVisible = false
   player2.isVisible = false
   ball.isVisible = false
   topLine.isVisible = false
   bottomLine.isVisible = false
   middleLine.isVisible = false
   option3.isVisible = false
   option4.isVisible = false
   textScore1.isVisible = false
   textScore2.isVisible = false
   object1.isVisible = false
   
   resetSpeed()
   resetBall()
   resetScore()
end
scene:addEventListener( "willEnterScene", scene )

function scene:enterScene( event )
   background.isVisible = true
   barbedwireright.isVisible = true
   barbedwireleft.isVisible = true
   player1.isVisible = true
   player2.isVisible = true
   ball.isVisible = true
   topLine.isVisible = false
   bottomLine.isVisible = false
   middleLine.isVisible = false
   option3.isVisible = false
   option4.isVisible = false
   textScore1.isVisible = true
   textScore2.isVisible = true
   object1.isVisible = true

   resetSpeed()
   resetBall()
   resetScore()

  Runtime:addEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "enterScene", scene )

function scene:exitScene( event )
   background.isVisible = false
   barbedwireright.isVisible = false
   barbedwireleft.isVisible = false
   player1.isVisible = false
   player2.isVisible = false
   ball.isVisible = false
   topLine.isVisible = false
   bottomLine.isVisible = false
   middleLine.isVisible = false
   option3.isVisible = false
   option4.isVisible = false
   textScore1.isVisible = false
   textScore2.isVisible = false
   object1.isVisible = false
 
   resetSpeed()
   resetScore()
   Runtime:removeEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "exitScene", scene )

function scene:didExitScene( event )
   print( "This scene has fully transitioned out and is no longer the active scene." )
end
scene:addEventListener( "didExitScene", scene )

function startGame()

  score1 = 0
  score2 = 0
  maxScore = 2

  direction = 3
  speed = 1
 

  hitplayer1 = false
  hitplayer2 = false
  
  allow1 = false
  allow2 = false
  
  singleplayer = true
  gameover = false

  player1 = display.newRect(leftX+30, topY + screenH/2 - screenH/13, screenW/80, screenH/7)
  player2 = display.newRect(rightX-10 - screenW/20, topY + screenH/2 - screenH/13, screenW/80, screenH/7)
    player1:setFillColor(150,150,150)
        player2:setFillColor(150,150,150)

  topLine = display.newLine(leftX + screenW/15, topY, rightX - screenW/14.5, topY)
  topLine.width = screenH/19

  bottomLine = display.newLine(leftX + screenW/15, bottomY, rightX - screenW/14.5, bottomY)
  bottomLine.width = screenH/20

  middleLine = display.newLine(leftX + screenW/2, topY, leftX + screenW/2, bottomY)
  middleLine.width = screenH/100

  textScore1 = display.newText( score1, leftX + screenW/2 - screenW/9, topY + screenH/50, native.systemFont, 50 )
  textScore2 = display.newText( score2, leftX + screenW/2 + screenW/16, topY + screenH/50, native.systemFont,50 )

  textScore1.alpha = 0.5
  textScore2.alpha = 0.5
  
  option3 = display.newText( "Player 1", leftX + screenW/8, textScore1.y + screenH/3.3, native.systemFont, 50 )
  option4 = display.newText( "Player 2", leftX + screenW/2 + screenW/18, textScore2.y + screenH/3.3 , native.systemFont, 50 )

  ball = display.newCircle(leftX + screenW/2, topY + screenH/2, screenW/25)
  ball:setFillColor(225,0,0)

  Runtime:addEventListener("touch", selectOption)
end

function updateGame(event)
  checkCollisions()
  moveBall()
  updateScore()
end

function updateScore()
  if score1 >= maxScore or score2 >= maxScore then
    score1 = 0
    score2 = 0
  end
  startGame()
 
  
  textScore1.text = score1
  textScore2.text = score2
end

function move1( event )--movement of player 1
    if event.phase == "began" and event.x < screenW/2 and event.y > player1.y - screenH/10 and event.y < player1.y + screenH/10 then
  
        markY = player1.y    -- store y location of object
    allow1 = true
  end
    if allow1 == true and event.x < screenW/2 then
  
        local y = (event.y - event.yStart) + markY
        
        player1.y = y    -- move object based on calculations above
  end
  if event.phase == "ended" and event.x < screenW/2 then
    allow1 = false
    end
    
    return true
end

function cpumove()--movement of cpu

  if ball.y > player2.y then
    player2.y = player2.y + 5
  elseif ball.y < player2.y then
    player2.y = player2.y - 8
  end
end

function move2( event )--movement of player
    if event.phase == "began" and event.x > screenW/2 and event.y > player2.y - screenH/10 and event.y < player2.y + screenH/10 then
  
        mark2Y = player2.y    -- store y location of object
    allow2 = true
  end
    if allow2 == true and event.x > screenW/2 then
  
        local y = (event.y - event.yStart) + mark2Y
        
        player2.y = y    -- move object based on calculations above
  end
  if event.phase == "ended" and event.x > screenW/2 then
    allow2 = false
    end
    
    return true
end

function moveBall()--movement of ball
  if direction == 1 then
    ball.x = ball.x + speed
    ball.y = ball.y - speed
  elseif direction == 2 then
    ball.x = ball.x - speed
    ball.y = ball.y - speed
  elseif direction == 3 then
    ball.x = ball.x - speed
    ball.y = ball.y + speed
  elseif direction == 4 then
    ball.x = ball.x + speed
    ball.y = ball.y + speed
  end
end

function checkCollisions()--collisions
  if player1.y + player1.height/5 > bottomY then
    player1.y = bottomY - player1.height/2
  elseif player1.y - player1.height/5 < topY then
    player1.y = topY + player1.height/2
  end
  
  if player2.y + player2.height/2 > bottomY then
    player2.y = bottomY - player2.height/2
  elseif player2.y - player2.height/2 < topY then
    player2.y = topY + player2.height/2
  end

  
  if ball.y + screenW/150 < topLine.y + screenH/19 then--touch  
    if direction == 1 then
      direction = 4
    elseif direction == 2 then
      direction = 3

    end
  elseif ball.y + screenW/300 > bottomLine.y - screenH/20 then
    if direction == 3 then
      direction = 2
    elseif direction == 4 then
      direction = 1
    end
  end
  
  if (inside(ball,player1) and hitplayer1 == false) then--hitting the ball
    hitplayer1 = true
    resetBallColor3()
    hitplayer2 = false
    speed = speed + 0.5

    if direction == 2 then
      direction = 1
    elseif direction == 3 then
      direction = 4
    end
  elseif (inside(ball,player2) and hitplayer2 == false) then--hitting the ball
    hitplayer2 = true
    resetBallColor4()
    hitplayer1 = false
    speed = speed + 0.5
    if direction == 1 then
      direction = 2
    elseif direction == 4 then
      direction = 3
    end
  end
  
    if ball.x < leftX + 40 then--if ball is out
    score2 = score2 + 1
    if score1 >= maxScore or score2 >= maxScore then
      gameover = true
    end

Runtime:removeEventListener("enterFrame",updateGame)
    Runtime:addEventListener("touch",selectOption)
    resetGame(2)
    resetBallColor2()
    resetPlayers()

  elseif ball.x > rightX - 40 then--if ball is out
    score1 = score1 + 1
    if score1 >= maxScore or score2 >= maxScore then
    gameover = true
    end
    resetGame(1)

Runtime:removeEventListener("enterFrame",updateGame)
    Runtime:addEventListener("touch",selectOption)
    resetPlayers()
    resetBallColor1()
  end
end

function resetBallColor1()--ball color red

  ball:setFillColor(255,0,0)
end
function resetBallColor2()--ball color blue

ball:setFillColor(0,0,255)  
end

function resetBallColor3()--ball color yellow

  ball:setFillColor(255,255,0)
end
function resetBallColor4()--ball color white

  ball:setFillColor(255,255,255)
end
function resetBall()
  ball.x = leftX + screenW/2
  ball.y = topY + screenH/2
  
end

function resetPlayers()
  player1.y = topY + screenH/2
  player2.y = topY + screenH/2
end
function resetSpeed()
  speed = 1
end
function resetScore()
  score1 = 0
  score2 = 0
end

function resetGame(n)
  local z = math.random(1,2)
  if n == 1 then
    if z == 1 then
      direction = 2
    elseif z == 2 then
      direction = 3
    end
  elseif n == 2 then
    if z == 1 then
      direction = 1
    elseif z == 2 then
      direction = 4
    end
  end
  resetBall()
  speed = 1
  hitplayer1 = false
  hitplayer2 = false
  if gameover == true then
    resetPlayers()

Runtime:removeEventListener("enterFrame",updateGame)
    Runtime:addEventListener("touch",selectOption)

  end
end

function inside(obj1, obj2)
        return obj1.contentBounds.xMin < obj2.contentBounds.xMax
                and obj1.contentBounds.xMax > obj2.contentBounds.xMin
                and obj1.contentBounds.yMin < obj2.contentBounds.yMax
                and obj1.contentBounds.yMax > obj2.contentBounds.yMin
end

function selectOption(event)
  if event.x < screenW/2 then
    singleplayer = true
  elseif event.x > screenW/2 then
    singleplayer = true
  end
  
  Runtime:addEventListener("touch", move1)
  if singleplayer==false then
    Runtime:addEventListener("touch", move2)
  else Runtime:addEventListener("enterFrame", cpumove)
  end
  Runtime:addEventListener("enterFrame",updateGame)
  Runtime:removeEventListener("touch",selectOption)
  gameover = false

  resetSpeed()
  resetBallColor1()
end
startGame()
return scene