_G.love = require("love")
require 'class'  --importing class library
require 'Player' --importing player class
require 'Ball'
_G.windowWidth = 1280
_G.windowHeight = 720
_G.speed = 450
_G.player1Score = 0;
_G.player2Score = 0;
function love.load() --lodaing data when game boots up
    math.randomseed(os.time())
    love.window.setMode(windowWidth, windowHeight, { fullscreen = false, vsync = true })
    _G.fpsFont = love.graphics.newFont("PressStart2P-Regular.ttf", 6)
    _G.scoreFont = love.graphics.newFont("PressStart2P-Regular.ttf", 60)

    _G.player1 = Player(50, 15, 30, 110, true, speed)
    _G.player2 = Player(1200, 595, 30, 110, false, speed)
    _G.ball = Ball(windowWidth / 2 + 30, windowHeight / 2, 30, 30, speed)

    _G.gameState = "start";
end

function love.update(dt) --runs every 60 frames
    if gameState == 'play' then
        ball:update(dt)
    end
    if ball:collides(player1) then
        ball.dx = -ball.dx * 1.03
        ball.x = player1.x + 30
        if ball.dy < 0 then
            ball.dy = -math.random(-10, 150)
        else
            ball.dy = math.random(-10, 150)
        end
    end
    if ball:collides(player2) then
        ball.dx = -ball.dx * 1.03
        ball.x = player2.x - 30
        if ball.dy < 0 then
            ball.dy = -math.random(-10, 150)
        else
            ball.dy = math.random(-10, 150)
        end
    end
    -- Upper and lower screen edges handling the ball
    if ball.y <= 0 then
        ball.y = 0
        ball.dy = -ball.dy
    end
    if ball.y >= windowHeight - 30 then
        ball.y = windowHeight - 30
        ball.dy = -ball.dy
    end
    -- Gaolscoring

    if ball.x <= 0 then
        player2Score = player2Score + 1
        ball:reset()
        gameState = 'start'
    end
    if ball.x >= windowWidth then
        player1Score = player1Score + 1
        ball:reset()
        gameState = 'start'
    end
    player1:update(dt)
    player2:update(dt)
end

function love.draw() --draws to the screen
    love.graphics.setFont(scoreFont)
    love.graphics.print(player2Score, windowWidth / 2 + 120, windowHeight / 12)
    love.graphics.print(player1Score, windowWidth / 2 - 120, windowHeight / 12)
    player1:render()
    player2:render()
    ball:render()
    displayFPS()
end

function love.keypressed(key)
    -- keys can be accessed by string name
    if key == 'escape' then
        -- function LÖVE gives us to terminate application
        love.event.quit()
        -- if we press enter during the start state of the game, we'll go into play mode
        -- during play mode, the ball will move in a random direction
    elseif key == 'space' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            -- ball's new reset method
            ball:reset()
        end
    end
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(fpsFont)
    love.graphics.setColor(0, 255 / 255, 0, 255 / 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end
