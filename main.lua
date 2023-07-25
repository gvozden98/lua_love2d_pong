_G.love = require("love")
require 'class'  --importing class library
require 'Player' --importing player class
require 'Ball'

function love.load() --lodaing data when game boots up
    _G.windowWidth = 1280
    _G.windowHeight = 720
    _G.speed = 450
    _G.player1Score = 0
    _G.player2Score = 0
    _G.winningPlayer = nil
    _G.sounds = {
        ['paddle_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static')
    }
    math.randomseed(os.time())
    love.window.setMode(windowWidth, windowHeight, { fullscreen = false, vsync = true })
    _G.fpsFont = love.graphics.newFont("PressStart2P-Regular.ttf", 6)
    _G.scoreFont = love.graphics.newFont("PressStart2P-Regular.ttf", 60)
    _G.playAgainFont = love.graphics.newFont("PressStart2P-Regular.ttf", 30)

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
            ball.dy = -math.random(-150, 150)
        else
            ball.dy = math.random(-150, 150)
        end
        sounds["paddle_hit"]:play()
    end
    if ball:collides(player2) then
        ball.dx = -ball.dx * 1.1
        ball.x = player2.x - 30
        if ball.dy < 0 then
            ball.dy = -math.random(-150, 150)
        else
            ball.dy = math.random(-150, 150)
        end
        sounds["paddle_hit"]:play()
    end
    -- Upper and lower screen edges handling the ball
    if ball.y <= 15 then
        ball.y = 15
        ball.dy = -ball.dy
        sounds["wall_hit"]:play()
    end
    if ball.y >= windowHeight - 15 then
        ball.y = windowHeight - 15
        ball.dy = -ball.dy
        sounds["wall_hit"]:play()
    end
    -- Gaolscoring

    if ball.x <= 0 then
        player2Score = player2Score + 1
        sounds["score"]:play()
        ball:reset()
        gameState = 'start'
        if player2Score == 5 then
            winningPlayer = 2
            gameState = "done"
        end
    end
    if ball.x >= windowWidth then
        player1Score = player1Score + 1
        sounds["score"]:play()
        ball:reset()
        gameState = 'start'
        if player1Score == 5 then
            winningPlayer = 1
            gameState = "done"
        end
    end

    if gameState == 'done' then
        player1Score = 0;
        player2Score = 0;
    end
    player1:update(dt)
    player2:update(dt)
end

function love.draw() --draws to the screen
    love.graphics.setFont(scoreFont)
    love.graphics.print(player2Score, windowWidth / 2 + 120, windowHeight / 12)
    love.graphics.print(player1Score, windowWidth / 2 - 120, windowHeight / 12)
    love.graphics.setFont(scoreFont)
    if gameState == 'done' then
        love.graphics.print("Player " .. winningPlayer .. " won", windowWidth / 2 - 350, 150)
        love.graphics.setFont(playAgainFont)
        love.graphics.print("Press space to play again", windowWidth / 2 - 370, 250)
    end
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
        elseif gameState == 'done' then
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
