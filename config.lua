--calculate the aspect ratio of the device:
local aspectRatio = display.pixelHeight / display.pixelWidth

application = {
   content = {
      width = aspectRatio > 1.5 and 320 or math.ceil( 480 / aspectRatio ),
      height = aspectRatio < 1.5 and 480 or math.ceil( 320 * aspectRatio ),
      scale = "letterBox",
      fps = 60,
      graphicsCompatibility = 1,
      xAlign = "center",
      yAlign = "center",

      imageSuffix = {
         ["@2x"] = 1.5,
         ["@4x"] = 3.0,

         width = 320,
    height = 480, 
    scale = "letterBox",
    fps = 30,
    
    --[[
    imageSuffix =
    {
          ["@2x"] = 2,
          ["@4x"] = 4,
    },
    --]]

  

      },
   },

    notification = {
            iphone = {
                types = {
                    "badge", "sound", "alert"
                }
            }
    }

}
