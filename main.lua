widget = require("widget")
require("soundFiles")

local object3 = display.newImageRect( "backgroundmain.png", 600, 330)
  object3.x = display.contentCenterX
  object3.y = display.contentCenterY

local storyboard = require "storyboard"
local scene = storyboard.newScene()
  centerX = display.contentWidth / 2
  centerY = display.contentHeight / 2
  
local object2 = display.newImageRect( "background11.png", 600, 330)
  object2.x = display.contentCenterX
  object2.y = display.contentCenterY



   local object1 = widget.newButton{
    width = 150,
    height = 50,
    defaultFile = "tap.png",
    overFile = "tap1.png",
    }
    object1.x = centerX
    object1.y = centerY + 90
    object1:addEventListener( "tap", object1 )


local function onUpdate( event )

end

function scene:createScene( event )
   local group = self.view
    object1.x = centerX
    object1.y = centerY
  group:insert( object1 )
  group:insert( object2 )
  group:insert( object3 )
 
end
scene:addEventListener( "createScene", scene )

function scene:willEnterScene( event )
   object1.isVisible = false
   object2.isVisible = false
   object3.isVisible = false
end
scene:addEventListener( "willEnterScene", scene )

function scene:enterScene( event )
   object1.isVisible = false
   object2.isVisible = false
   object3.isVisible = false
    
   Runtime:addEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "enterScene", scene )

function scene:exitScene( event )
   object1.isVisible = false
   object2.isVisible = false
   object3.isVisible = false

   Runtime:removeEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "exitScene", scene )

function scene:didExitScene( event )
   print( "This scene has fully transitioned out and is no longer the active scene." )
end
scene:addEventListener( "didExitScene", scene )

function object1:tap( event )
    playSFX(audioclick)  
    object1.isVisible = false
    object2.isVisible = false
    object3.isVisible = true
    storyboard.gotoScene ("mainscreen", { effect = "zoomOutIn"})
end

return scene