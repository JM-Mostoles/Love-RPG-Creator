function love.load()
    require("modules.easyTimer")
    temporizador = timer_class.new(0, 0, 1, false, false)
end

function love.update(dt)
    temporizador:update(dt)
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

function love.draw()
    love.graphics.print(math.ceil(temporizador.currentTime))
end