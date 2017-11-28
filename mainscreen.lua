require("soundFiles")
widget = require("widget")
centerX = display.contentWidth / 2
centerY = display.contentHeight / 2
 
 
local storyboard = require ("storyboard")
local scene = storyboard.newScene()
storyboard.purgeOnSceneChange = false
 

playSFX(blop_sound)
playgameMusic(gamebgmusic)

local myButton1 = widget.newButton{
    width = 120,
    height = 50,
    defaultFile = "button1.png",
    overFile = "button2.png",
    onPress = push1,
    
    }
myButton1:addEventListener( "tap", myButton1 )
function myButton1:tap( event )
    superGroup.isVisible = false
    playSFX(blop_sound)  

    storyboard.gotoScene ("screen1", { effect = "zoomOutIn"})
end


local myButton2 = widget.newButton{
    width = 120,
    height = 50,
    defaultFile = "button3.png",
    overFile = "button5.png",
    onPress = push1,
    
    }
myButton2:addEventListener( "tap", myButton2 )
function myButton1:tap( event )
    playSFX(audioclick)  

    storyboard.gotoScene ("screen1", { effect = "zoomOutIn"})
end

local myButton3 = widget.newButton{
    width = 120,
    height = 50,
    defaultFile = "button4.png",
    overFile = "button6.png",
    onPress = push1,
    
    }
myButton3:addEventListener( "tap", myButton3 )
function myButton3:tap( event )
    superGroup.isVisible = false
    playSFX(audioclick)  

    storyboard.gotoScene ("developers", { effect = "zoomOutIn"})
end

local myButton4 = widget.newButton{
    width = 100,
    height = 30,
    defaultFile = "button11.png",
    overFile = "button12.png",
    onPress = nil,
    
    }
myButton4:addEventListener( "tap", myButton4 )
function myButton4:tap( event )
    superGroup.isVisible = false
    playSFX(audioclick)  

    storyboard.gotoScene ("screen1", { effect = "zoomOutIn"})
end

myButton1.x = centerX
myButton1.y = 0

myButton2.x = centerX
myButton2.y = display.contentHeight + 50

myButton3.x = centery
myButton3.y = display.contentHeight + 100

myButton4.x = centery
myButton4.y = display.contentHeight + 30


local gameTitle = display.newImage("gameTitle.png")
gameTitle.x = -50
gameTitle.y = -50

function showTitle()
    
    gameTitle.alpha = 0
    gameTitle.x = centerX
    gameTitle.y = centerY - 50
    gameTitle:scale(4,4)
    transition.to(gameTitle, {time=500, alpha=1, xScale=1, yScale=1})
end

transition.to(myButton1, {time=1000, alpha=1, y = centerY + 10, x=centerX, onComplete=showTitle})
transition.to(myButton2, {time=1000, alpha=1, y = centerY + 65, x=centerX})
transition.to(myButton3, {time=1000, alpha=1, y = centerY + 120, x=centerX})
transition.to(myButton4, {time=1000, alpha=1, y = centerY + 130, x=centerX / 4.5})

function myButton2:tap( event )
    playSFX(audioclick)  

    storyboard.gotoScene ("instructions", { effect = "zoomOutIn"})     
end

function myButton3:tap( event )
    playSFX(audioclick)  

    storyboard.gotoScene ("developers", { effect = "zoomOutIn"})     
end

function myButton4:tap( event )
    playSFX(audioclick)  

    storyboard.gotoScene ("quit", { effect = "zoomOutIn"})     
end


    
local function onUpdate( event )

end

function scene:createScene( event )
   local group = self.view

    group:insert( myButton1)
    group:insert( myButton3)
    group:insert( myButton2)
    group:insert( myButton4)

end
scene:addEventListener( "createScene", scene )

function scene:willEnterScene( event )
   myButton1.isVisible = false
   myButton3.isVisible = false
   myButton4.isVisible = false
   myButton2.isVisible = false
    gameTitle.isVisible = false
end
scene:addEventListener( "willEnterScene", scene )

function scene:enterScene( event )
  myButton1.isVisible = true
  myButton3.isVisible = true
  myButton4.isVisible = true
  myButton2.isVisible = true
    gameTitle.isVisible = true
  Runtime:addEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "enterScene", scene )

function scene:exitScene( event )
   myButton1.isVisible = true
   myButton3.isVisible = true
   myButton4.isVisible = true
   myButton2.isVisible = true
    gameTitle.isVisible = false
   Runtime:removeEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "exitScene", scene )

function scene:didExitScene( event )
   print( "This scene has fully transitioned out and is no longer the active scene." )
end
scene:addEventListener( "didExitScene", scene )


return scene


