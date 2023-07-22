_G.love = require("love")
_G.windowWidth = 1280
_G.windowHeight = 720
_G.Player1Y = 90
_G.Player2Y = 540
_G.speed = 250
function love.load() --lodaing data when game boots up
    love.window.setMode(windowWidth,windowHeight,{fullscreen = false,vsync=true})
end

function love.update(dt) --runs every 60 frames
    if love.keyboard.isDown("escape") then
        love.event.quit()        
    end
    if love.keyboard.isDown("s") then
        
        if Player1Y >= windowHeight-160 then
            Player1Y = windowHeight-160
        end
        Player1Y = Player1Y+speed *dt*1.03
    end
    if love.keyboard.isDown("w") then
        if Player1Y <= 90 then
            Player1Y = 90
        end
        Player1Y = Player1Y -speed *dt *1.03
    end
    if love.keyboard.isDown("down") then
        
        if Player2Y >= windowHeight-160 then
            Player2Y = windowHeight-160
        end
        Player2Y = Player2Y+speed *dt*1.03
    end
    if love.keyboard.isDown("up") then
        if Player2Y <= 90 then
            Player2Y = 90
        end
        Player2Y = Player2Y -speed *dt *1.03
    end
end

function love.draw() --draws to the screen 
    --love.graphics.print("hello World")
    love.graphics.rectangle("fill",50,Player1Y,30,110)
    love.graphics.rectangle("fill",1200,Player2Y,30,110)
end