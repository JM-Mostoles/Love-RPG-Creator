function love.load()
	require("modules.textMaker")
	hola = textbox_class.new(true, 20, { "Doesn't this feel...", "...", "Sussy" },1, 1, 1, 1, "Ninten")
end

function love.update(dt)
	hola:update(dt)
	if hola.typewriter_linesIndex == 3 then
		hola:changeColor(1, 0, 0, 1)
	end
end

function love.keypressed(key)
	hola:keypressed(key)
	if hola.general_isIn == false then
		if key == "a" then
			hola:setIn(true)
		end
	end
	if key == "1" then
		hola:setAtBottom(true)
	end

	if key == "2" then
		hola:setAtBottom(false)
	end

	if key == "3" then
		hola:modifyName(0, 1, 0, 1)
	end
	if key == "4" then
		hola:modifyName(1, 1, 0, 1, "setNameBlank")
	end
end

function love.draw()
	love.graphics.draw(love.graphics.newImage("rs/general/bg.png"))
	hola:draw(dt)
end
