Player = class {}

function Player:init(x, y, width, height, leftPlayer, speed)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.leftPlayer = leftPlayer
    self.speed = speed
end

function Player:update(dt)
    if self.leftPlayer == true then
        if love.keyboard.isDown("s") then
            if self.y >= windowHeight - 160 then
                self.y = windowHeight - 160
            end
            self.y = self.y + self.speed * dt * 1.03
        end
        if love.keyboard.isDown("w") then
            if self.y <= 90 then
                self.y = 90
            end
            self.y = self.y - self.speed * dt * 1.03
        end
    elseif self.leftPlayer == false then
        if love.keyboard.isDown("down") then
            if self.y >= windowHeight - 160 then
                self.y = windowHeight - 160
            end
            self.y = self.y + self.speed * dt * 1.03
        end
        if love.keyboard.isDown("up") then
            if self.y <= 90 then
                self.y = 90
            end
            self.y = self.y - self.speed * dt * 1.03
        end
    end
end

function Player:render()
    --if self.leftPlayer then --self.x = 50
    --print(self.x, self.y, self.width, self.height)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    --elseif self.leftPlayer == false then
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height) --self.x =1200
    --end
end
