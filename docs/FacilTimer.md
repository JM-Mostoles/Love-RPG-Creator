# FacilTimer

## Usage

FacilTimer is a very plain and simple chronometer type of countdown, to create one, you must use the following arguments at the block where you're gonna instanciate the timer:

```lua
function love.load()
    local FacilTimer = require("modules.FacilTimer")

    timerName = FacilTimer.new(
	(Start at, int recommended), 
	(Finish at, int recommended), 
	(Speed, int recommended), 
	(Loops, a boolean), 
	(Starts paused? a boolean) 
	)
end
```

By default, the .new() arguments are the following:
```lua
1, 0, 1, false, true
```

## Methods

- :paused(boolean)
- :alternatePause()  
  [If paused, resumes, and viceversa]
- :willLoop(boolean)
- :toggleLoop()
- :update(dt)  
  [IMPORTANT! Makes everything work]

## Example of usage

```lua

--Main.lua 

local myTimer

function love.load()
    local FacilTimer = require("modules.FacilTimer")
    myTimer = FacilTimer.new(10, 0, 5, true, true)
end

function love.update(dt)
    myTimer:update(dt)
end

function love.keypressed(key)
	if key == "1" then
		myTimer:alternatePause()
	elseif key == "2" then
		myTimer:paused(true)
	elseif key == "3" then
		myTimer:paused(false)
	elseif key == "4" then
		myTimer:willLoop(true)
	elseif key == "5" then
		myTimer:willLoop(false)
	elseif key == "6" then
		myTimer:toggleLoop()
	end
end

function love.draw()
    love.graphics.print(math.ceil(myTimer.currentTime))
end


```
