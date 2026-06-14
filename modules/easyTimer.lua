timer_class = {
	startAt = 0,
	finishAt = 0,
	currentTime = 0,
	speed = 1,
	loops = true,
	isPaused = false,
}

function timer_class:pause()
	self.isPaused = true
end

function timer_class:resume()
	self.isPaused = false
end

function timer_class:toggleTimer()
	self.isPaused = not self.isPaused
end

function timer_class:wontLoop()
	self.loops = false
end

function timer_class:willLoop()
	self.loops = true
end

function timer_class:toggleLoop()
	self.loops = not self.loops 
end


function timer_class:update(dt)
	if self.isPaused == false then

		self.currentTime = self.currentTime - (self.speed * dt)

		if self.currentTime <=  self.finishAt then
			if self.loops then
				self.currentTime = self.startAt
			else 
				self:pause()
				self.currentTime = self.finishAt
			end
		end
	end
end

local metaTimer = {}
metaTimer.__index = timer_class

function timer_class.new(startAt, finishAt, speed, loops, startPaused)
	local instance = setmetatable({}, metaTimer)

	instance.startAt = startAt or 10
	instance.finishAt = finishAt or 0
    instance.currentTime = instance.startAt
	instance.speed = speed or 1
	instance.loops = loops ~= false
	instance.isPaused = startPaused == true

	return instance
end
