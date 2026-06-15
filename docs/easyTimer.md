# EasyTimer

## Usage

Easytimer is a very plain and simple chronometer type of countdown, to create one, you must use the following statement at the logic where you're gonna make the timer:

```lua
timerName = timer_class.new( (Start at, int recommended), (Finish at, int recommended), (Speed, int recommended), (Loops, a boolean), (Starts paused? a boolean) )
```

"timer_class" is a global variable. But you must require the module for safety.

By default, the .new() arguments are the following:
```lua
1, 0, 1, false, true
```

## Methods

- :paused(boolean)
- :alternatePause() [If paused, resumes, and viceversa]
- :willLoop(boolean)
- :toggleLoop()
- :update(dt) [IMPORTANT! Makes everything work.]

## Example of usage

```lua

--Main.lua

function love.load()
    require("modules.easyTimer")
    timerName = timer_class.new(10, 0, 1, false, false)
end

function love.update(dt)
    timerName:update(dt)
end

function love.draw()
    love.graphics.print(math.ceil(timerName.currentTime))
end

```
