function love.load()
    Didy = require("FacilPlayer")
    Blud = require("FacilObstacle")
    playah = Didy.new(50, 50, 20, 10, 100)
    testObstacle = Blud.new(70, 70, 30, 30, playah)
    testObstacle2 = Blud.new(160, 180, 30, 30, playah)
    testObstacle3 = Blud.new(220, 180, 30, 90, playah)
end

function love.update(dt)
    playah:update(dt)
    testObstacle:update(dt)
    testObstacle2:update(dt)
    testObstacle3:update(dt)
end

function love.keyreleased(key)
    playah:keyreleased(key)
end

function love.draw()
    playah:draw()
    testObstacle:draw()
    testObstacle2:draw()
    testObstacle3:draw()
end
