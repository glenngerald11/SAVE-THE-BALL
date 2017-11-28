widget = require("widget")
require("soundFiles")

local storyboard = require "storyboard"
local scene = storyboard.newScene()
centerX = display.contentWidth / 2
centerY = display.contentHeight / 2

   local object1 = widget.newButton{
    width = 50,
    height = 50,
    defaultFile = "back.png",
    overFile = "back_down.png",
    }
   object1:addEventListener( "tap", object1 )
   local instructions = display.newImage("instructions.png")

local function onUpdate( event )

end

function scene:createScene( event )
   local group = self.view
    object1.x = centerX/10
    object1.y = centerY/6
   group:insert( object1 )
          instructions.x = 270
    instructions.y = 200
   group:insert( instructions )

end
scene:addEventListener( "createScene", scene )

function scene:willEnterScene( event )
   object1.isVisible = true
   instructions.isVisible = true
end
scene:addEventListener( "willEnterScene", scene )

function scene:enterScene( event )
   object1.isVisible = true
    instructions.isVisible = true
   Runtime:addEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "enterScene", scene )

function scene:exitScene( event )
   object1.isVisible = true

instructions.isVisible = true
   Runtime:removeEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "exitScene", scene )

function scene:didExitScene( event )
   print( "This scene has fully transitioned out and is no longer the active scene." )
end
scene:addEventListener( "didExitScene", scene )

function object1:tap( event )
    playSFX(audioclick)  

    storyboard.gotoScene ("mainscreen", { effect = "zoomOutIn"})
end

return scene