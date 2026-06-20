# FacilTextbox

## Usage

FacilTextbox is a very easy way to instanciate classic RPG style dialogues in your LÖVE project! Manage many lines of dialogue, and call it in whenever you want.
You may create one with the subsequent parameters in your block of code:

```lua
local myTextbox

function love.load()
	local FacilTextbox = require("modules.FacilTextbox")

	myTextbox = myTextbox = FacilTextbox.new(
		(Will appear at bottom?, a boolean), 
		(Speed, int recommended), 
		(lines, a table of strings), 
		(red value, int recommended), 
		(green value, int recommended), 
		(blue value, int recommended), 
		(Alpha value, a number) 
	)
end
```

"FacilTextbox_class" is a global variable. But you must require the module for safety.

By default, the .new() arguments are the following:
```lua
true, 2, {"Whats so green about this...", "Lorem ipsum dolor sit amet", "Morbi vestibulum euismod", "Sed malesuada augue lacus"}, 1, 1, 1, 1
```

## Methods

- setIn(boolean)
- :setAtBottom(bool)
- :changeColor(red value, green value, blue value, alpha value)  
[Changes color of the text.]
- :modifyName(red value, green value, blue value, alpha value, new Speaker)  
[Changes color of the speaker label and allows you to remove it by setting it to removeName. If no speaker was set, adding a name will set it.]
- :setPitch(pitch)  
[High or low. You may want to add your own sounds though. So feel free to modify whatever you need.]
- :update(dt)  
[IMPORTANT! Makes everything work.]
- :draw(dt)  
[IMPORTANT! Makes everything work.]

## Example of usage

```lua

--Main.lua

local myTextbox

function love.load()
	local FacilTextbox = require("modules.FacilTextbox")
	myTextbox = FacilTextbox.new(true, 20, { "Like the wind", "you came running" }, 1, 1, 1, 1)
end

function love.update(dt)
	myTextbox:update(dt)
        if myTextbox.typewriter_linesIndex == 2 then
            myTextbox:modifyName(1, 0, 1, 1, "FEX")
            myTextbox:changeColor(1, 1, 0, 1)
        end
    end

function love.keypressed(key)
	myTextbox:keypressed(key)
	if myTextbox.general_isIn == false then
		if key == "a" then
			myTextbox:setIn(true)
		end
	end
end

function love.draw()
	myTextbox:draw()
end


```
