function love.load()
    FacilPlayer = {
        X = 15,
        Y = 15,
        oX = 15,
        oY = 15,
        cW = 30,
        cH = 30,
        speed = 100,
        xDir = 0,
        yDir = 0,
        rightKey = love.keyboard.isDown("right"),
        leftKey = love.keyboard.isDown("left"),
        upKey = love.keyboard.isDown("up"),
        downKey = love.keyboard.isDown("down")
    }

    FacilObstacle = {
        X = 105,
        Y = 105,
        oX = 15,
        oY = 15,
        cW = 40,
        cH = 40,
    }

    function FacilPlayer.detectObstacle()
        return FacilPlayer.X < FacilObstacle.X + FacilObstacle.cW and
            FacilPlayer.X + FacilPlayer.cW > FacilObstacle.X and
            FacilPlayer.Y < FacilObstacle.Y + FacilObstacle.cH and
            FacilPlayer.Y + FacilPlayer.cH > FacilObstacle.Y
    end
end

function love.update(dt)
    local oldX, oldY = FacilPlayer.X, FacilPlayer.Y

    FacilPlayer.rightKey = love.keyboard.isDown("right")
    FacilPlayer.leftKey = love.keyboard.isDown("left")
    FacilPlayer.upKey = love.keyboard.isDown("up")
    FacilPlayer.downKey = love.keyboard.isDown("down")

    if FacilPlayer.leftKey and FacilPlayer.xDir == 0 then FacilPlayer.xDir = -1 end
    if FacilPlayer.rightKey and FacilPlayer.xDir == 0 then FacilPlayer.xDir = 1 end
    if FacilPlayer.upKey and FacilPlayer.yDir == 0 then FacilPlayer.yDir = -1 end
    if FacilPlayer.downKey and FacilPlayer.yDir == 0 then FacilPlayer.yDir = 1 end

    if (FacilPlayer.xDir == 1) then
        FacilPlayer.X = FacilPlayer.X + (FacilPlayer.speed * dt)
    end
    if (FacilPlayer.xDir == -1) then
        FacilPlayer.X = FacilPlayer.X - (FacilPlayer.speed * dt)
    end
    if (FacilPlayer.yDir == 1) then
        FacilPlayer.Y = FacilPlayer.Y + (FacilPlayer.speed * dt)
    end
    if (FacilPlayer.yDir == -1) then
        FacilPlayer.Y = FacilPlayer.Y - (FacilPlayer.speed * dt)
    end

    if FacilPlayer.detectObstacle() then
        FacilPlayer.X, FacilPlayer.Y = oldX, oldY
    end
end

function love.keyreleased(key)
    if key == "right" or key == "left" then
        FacilPlayer.xDir = 0
    end
    if key == "up" or key == "down" then
        FacilPlayer.yDir = 0
    end
end

function love.draw()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", FacilPlayer.X - FacilPlayer.oX, FacilPlayer.Y - FacilPlayer.oY, FacilPlayer.cW,
        FacilPlayer.cH)
    love.graphics.setColor(1, 1, 1)

    love.graphics.setColor(1, 0, 1)
    love.graphics.rectangle("fill", FacilObstacle.X - FacilObstacle.oX, FacilObstacle.Y - FacilObstacle.oY,
        FacilObstacle.cW,
        FacilObstacle.cH)
    love.graphics.setColor(1, 1, 1)

    love.graphics.print(FacilPlayer.xDir)
    love.graphics.print(FacilPlayer.yDir, 0, 10)

    local thunk = FacilPlayer.detectObstacle()

    if thunk then
        love.graphics.print("Coll", 0, 20)
    end
end
