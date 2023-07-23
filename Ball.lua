Ball = class {}

function Ball:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end

function Ball:update(dt)
    self.x = self.x + self.dx * dt * 1.5
    self.y = self.y + self.dy * dt * 1.5
end

function Ball:render()
    love.graphics.circle("fill", self.x, self.y, 15)
end

function Ball:reset()
    self.x = windowWidth / 2
    self.y = windowHeight / 2
    self.dy = math.random(2) == 1 and -100 or 100
    self.dx = math.random(-50, 50)
end
