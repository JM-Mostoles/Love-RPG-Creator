# EasyTimer

## Usage

Easytimer is a very plain and simple chronometer type of countdown, to create one, you must use the following statement at the logic where you're gonna make the timer:

```lua
timerName = timer_class.new( Start at (Int recommended), Finish at (Int recommended), Speed (Int recommended), Loops (A     boolean), Starts paused? (A boolean) )
```

"timer_class" is a global variable. But you must require the module for safety.

By default, these values are 
```lua
1, 0, 1, false, true
```

## Methods

- :pause()
- :resume()
- :toggleTimer() [If paused, resumes, and viceversa]

- :wontLoop()
- :willLoop()
- :toggleLoop()

- :update(dt) [IMPORTANT! Makes everything work.]

## Example of usage

```lua

--Main.lua

function love.load()
    require("modules.easyTimer")
    myTimer = timer_class.new(10, 0, 1, false, false)
end

function love.update(dt)
    myTimer:update(dt)
end

function love.draw()
    love.graphics.print(math.ceil(myTimer.currentTime))
end

```