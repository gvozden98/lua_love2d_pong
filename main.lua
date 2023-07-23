_G.love = require("love")
require 'class'  --importing class library
require 'Player' --importing player class
require 'Ball'
_G.windowWidth = 1280
_G.windowHeight = 720
_G.speed = 250
function love.load() --lodaing data when game boots up
    math.randomseed(os.time())
    love.window.setMode(windowWidth, windowHeight, { fullscreen = false, vsync = true })
    _G.player1 = Player(50, 90, 30, 110, true, speed)
    _G.player2 = Player(1200, 540, 30, 110, false, speed)
    _G.ball = Ball(windowWidth / 2, windowHeight / 2, 30, 30)

    _G.gameState = "start";
end

function love.update(dt) --runs every 60 frames
    if love.keyboard.isDown("escape") then
        love.event.quit()
    elseif love.keyboard.isDown("kpenter") then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            -- ball's new reset method
            ball:reset()
        end
    end
    if gameState == 'play' then
        ball:update(dt)
    end

    player1:update(dt)
    player2:update(dt)
end

function love.draw() --draws to the screen
    --love.graphics.print("hello World")
    player1:render()
    player2:render()
    ball:render()
    displayFPS()
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setColor(0, 255 / 255, 0, 255 / 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
