# textMaker

## Usage

textMaker is a very easy way to instanciate classic RPG style dialogues in your LÖVE project ! Manage many lines of dialogue, and call it in and out whenever you want.
You may create one with the subsequent parameters:

```lua
require("pathTo.textMaker")

myTextbox = textbox_class.new( (Will appear at bottom?, a boolean), (Speed, int recommended), (lines, a table of strings), (red value, int recommended), (green value, int recommended), (blue value, int recommended), (Alpha value, a number) )
```

"textbox_class" is a global variable. But you must require the module for safety.

By default, the .new() arguments are the following:
```lua
true, 2, typewriter_lines = {"Whats so green about this...", "Lorem ipsum dolor sit amet", "Morbi vestibulum euismod", "Sed malesuada augue lacus"}, 1, 1, 1, 1
```

## Methods

- setIn(boolean)
  
- :update(dt) [IMPORTANT! Makes everything work.]
- :draw(dt) [IMPORTANT! Makes everything work.]

## Example of usage

```lua

--Main.lua

function love.load()
	require("modules.textMaker")
	hola = textbox_class.new(false, 10, { "aaaaaaaaaaaa", "bbbbbbbbbbbb" }, 1, 1, 1, 1)
end

function love.update(dt)
	hola:update(dt)
end

function love.keypressed(key)
	hola:keypressed(key)
	if hola.general_isIn == false then
		if key == "a" then
			hola:setIn(true)
		end
	end
end

function love.draw()
	love.graphics.draw(love.graphics.newImage("rs/general/bg.png"))
	hola:draw(dt)
end

```
