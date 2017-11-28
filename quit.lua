widget = require("widget")
require("soundFiles")


local storyboard = require "storyboard"
local scene = storyboard.newScene()



   local object4 = widget.newButton{
    width = 50,
    height = 50,
    defaultFile = "yes.png",
    overFile = "yes1.png",
    }
   object4:addEventListener( "tap", object4 )

   local object5 = widget.newButton{
    width = 50,
    height = 50,
    defaultFile = "no.png",
    overFile = "no1.png",
    }
   object5:addEventListener( "tap", object5 )

   local out = display.newImage("out.png")

local function onUpdate( event )

end


function scene:createScene( event )
   local group = self.view
    object4.x = 37
    object4.y = 283
   group:insert( object4 )

    object5.x = 530
    object5.y = 283
   group:insert( object5 )

    out.x = 270
    out.y = 180
   group:insert( out )

end
scene:addEventListener( "createScene", scene )

function scene:willEnterScene( event )
   object4.isVisible = true
   object5.isVisible = true
   out.isVisible = false
end
scene:addEventListener( "willEnterScene", scene )

function scene:enterScene( event )
   object4.isVisible = true
   object5.isVisible = true
   out.isVisible = true
    
   Runtime:addEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "enterScene", scene )

function scene:exitScene( event )
   object4.isVisible = true
   object5.isVisible = true
   out.isVisible = false

   Runtime:removeEventListener( "enterFrame", onUpdate )
end
scene:addEventListener( "exitScene", scene )

function scene:didExitScene( event )
   print( "This scene has fully transitioned out and is no longer the active scene." )
end
scene:addEventListener( "didExitScene", scene )

function object4:tap( event )
    playSFX(audioclick)  

 function quit() 
 os.exit() 
end 
timer.performWithDelay(1000,quit)

end

function object5:tap( event )
    playSFX(audioclick)  

        storyboard.gotoScene ("mainscreen", { effect = "zoomOutIn"})
end



return scene