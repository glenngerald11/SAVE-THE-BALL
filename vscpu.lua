widget = require("widget")
require("soundFiles")

local storyboard = require ("storyboard")
local scene = storyboard.newScene()


 local object1 = widget.newButton{
    width = 50,
    height = 50,
    defaultFile = "back.png",
    overFile = "back_down.png",
    }
   object1:addEventListener( "tap", object1 )



playSFX(audioLaunch)
playgameMusic(gamebgmusic)

local myButton1 = widget.newButton{
    width = 120,
    height = 50,
    defaultFile = "button13.png",
    overFile = "button14.png",
    onPress = push1,
    
    }
myButton1:addEventListener( "tap", myButton1 )
function myButton1:tap( event )
    superGroup.isVisible = false
    playSFX(audioclick)  

    storyboard.gotoScene ("multiplayers", { effect = "zoomOutIn"})
end


local myButton2 = widget.newButton{
    width = 120,
    height = 50,
    defaultFile = "button15.png",
    overFile = "button16.png",
    onPress = nil,
    
    }
myButton2:addEventListener( "tap", myButton2 )
function myButton1:tap( event )
    playSFX(audioclick)  

    storyboard.gotoScene ("easy", { effect = "zoomOutIn"})
end

function myButton2:tap( event )
    playSFX(audioclick)  

    storyboard.gotoScene ("hard", { effect = "zoomOutIn"})     
end

myButton1.x = centerX
myButton1.y = 0

myButton2.x = centerX
myButton2.y = display.contentHeight + 50


transition.to(myButton1, {time=1000, alpha=1, y = centerY-30, x=centerX})
transition.to(myButton2, {time=1000, alpha=1, y = centerY + 30, x=centerX})

    
local function onUpdate( event )

end

function scene:createScene( event )
   local group = self.view

    group:insert( myButton1)
    group:insert( myButton2)
   group:insert( object1 )

end
scene:addEventListener( "createScene", scene )

function scene:willEnterScene( event )
   myButton1.isVisible = true
   myButton2.isVisible = true
      object1.isVisible = true
end
scene:addEventListener( "willEnterScene", scene )

function scene:enterScene( event )
  myButton1.isVisible = true
   myButton2.isVisible = true
      object1.isVisible = true
   Runtime:addEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "enterScene", scene )

function scene:exitScene( event )
   myButton1.isVisible = true
   myButton2.isVisible = true
      object1.isVisible = true
   Runtime:removeEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "exitScene", scene )

function scene:didExitScene( event )
   print( "This scene has fully transitioned out and is no longer the active scene." )
end
scene:addEventListener( "didExitScene", scene )

function object1:tap( event )
    playSFX(audioclick)  

    storyboard.gotoScene ("screen1", { effect = "zoomOutIn"})
end

return scene


