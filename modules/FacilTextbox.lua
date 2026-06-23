-- Class properties
local FacilTextbox_class = {
	-- Textbox generals, image and position.
	general_isIn = false,
	general_X = (256 / 2),
	general_Y = (224 / 2),
	general_yPos = { bottom = 176, top = 48 },
	general_isAtBottom = true,
	general_textbox = love.graphics.newImage("rs/textMaker/tM_textbox.png"),

	-- Textbox's text elements
	-- Color
	typewriter_r = 1,
	typewriter_g = 1,
	typewriter_b = 1,
	typewriter_a = 1,
	-- Other elements
	typewriter_lines = {
		"Whats so green about this...",
		"Lorem ipsum dolor sit amet",
		"Morbi vestibulum euismod",
		"Sed malesuada augue lacus",
	},
	typewriter_font = love.graphics.newFont("rs/fonts/earlyGameBoy.ttf", 8),
	typewriter_linesIndex = 1,
	typewriter_shownText = "",
	typewriter_letterCount = 1,
	typewriter_speed = 20,

	-- Indicator
	indicator_image = love.graphics.newImage("rs/textMaker/tM_indicator.png"),
	indicator_quads = { love.graphics.newQuad(0, 0, 9, 7, 9, 14), love.graphics.newQuad(0, 7, 9, 7, 9, 14) },
	indicator_index = 1,
	indicator_timer = 1,
	indicator_isShowing = false,

	-- Name
	nameLabel_name = nil,
	nameLabel_r = 1,
	nameLabel_g = 1,
	nameLabel_b = 1,
	nameLabel_a = 1,

	-- Audio
	audio_tickHighPitch = love.audio.newSource("rs/audio/tick_highPitch.ogg", "static"),
	audio_tickLowPitch = love.audio.newSource("rs/audio/tick_lowPitch.ogg", "static"),
}

-- Other class atributes
FacilTextbox_class.text_full = FacilTextbox_class.typewriter_lines[FacilTextbox_class.typewriter_linesIndex]
FacilTextbox_class.oX = math.floor(FacilTextbox_class.general_textbox:getWidth() / 2)
FacilTextbox_class.oY = math.floor(FacilTextbox_class.general_textbox:getHeight() / 2)
FacilTextbox_class.currentPitch = FacilTextbox_class.audio_tickHighPitch

-- Class methods
function FacilTextbox_class:changeColor(r, g, b, a)
	self.typewriter_r = r
	self.typewriter_g = g
	self.typewriter_b = b
	self.typewriter_a = a
end

function FacilTextbox_class:modifyName(r, g, b, a, newSpeaker)
	self.nameLabel_r = r
	self.nameLabel_g = g
	self.nameLabel_b = b
	self.nameLabel_a = a
	self.nameLabel_name = newSpeaker or self.nameLabel_name
	if newSpeaker == "removeName" then
		self.nameLabel_name = nil
	end
end

function FacilTextbox_class:setIn(bool)
	self.typewriter_linesIndex = 1
	self.typewriter_letterCount = 1
	self.general_isIn = bool
	self:changeColor(1, 1, 1, 1)
	if bool == false then
		self:modifyName(1, 1, 1, 1, "removeName")
	end
end

function FacilTextbox_class:next()
	self.typewriter_letterCount = 1
	if self.typewriter_lines[self.typewriter_linesIndex + 1] ~= nil then
		self.typewriter_linesIndex = self.typewriter_linesIndex + 1
	else
		self:setIn(false)
	end
end

function FacilTextbox_class:setAtBottom(bool)
	self.general_isAtBottom = bool
end

function FacilTextbox_class:setPitch(pitch)
	if pitch == "High" then
		FacilTextbox_class.currentPitch = FacilTextbox_class.audio_tickHighPitch
	elseif pitch == "Low" then
		FacilTextbox_class.currentPitch = FacilTextbox_class.audio_tickLowPitch
	end
end

function FacilTextbox_class:update(dt)

	if self.general_isIn then

		self.text_full = self.typewriter_lines[self.typewriter_linesIndex]

		-- Textbox placement
		if self.general_isAtBottom then
			self.general_Y = self.general_yPos.bottom
		else
			self.general_Y = self.general_yPos.top
		end

		-- Text
		if self.typewriter_letterCount < #self.text_full then
			self.indicator_isShowing = false
			self.indicator_index = 1
			self.indicator_timer = 1
			self.typewriter_letterCount = self.typewriter_letterCount + (self.typewriter_speed * dt)
			-- Sound
			local letters = math.floor(self.typewriter_letterCount)
			if letters % 2 == 0 then
				local source = self.currentPitch:clone()
				source:play()
			end
		else
			-- Animating the indicator
			self.indicator_timer = self.indicator_timer + (4 * dt)
			if self.indicator_timer > 3 then
				self.indicator_timer = 1
			end

			if self.indicator_timer >= 1 and self.indicator_timer < 2 then
				self.indicator_index = 1
			elseif self.indicator_timer >= 2 then
				self.indicator_index = 2
			end

			self.indicator_isShowing = true
		end

		-- Displaying text
		self.typewriter_shownText = string.sub(self.text_full, 1, self.typewriter_letterCount)
	end
end

function FacilTextbox_class:keypressed(key)

	if self.general_isIn then

		-- Skip text
		if
			(key == "rshift" and self.typewriter_letterCount < #self.text_full)
			or (key == "x" and self.typewriter_letterCount < #self.text_full)
		then
			self.typewriter_letterCount = #self.text_full
		end
		
		-- Continue text
		if
			(key == "return" and self.typewriter_letterCount >= #self.text_full)
			or (key == "z" and self.typewriter_letterCount >= #self.text_full)
		then
			self:next()
		end
	end
end

function FacilTextbox_class:draw()
	if self.general_isIn then
		-- Textbox
		love.graphics.draw(self.general_textbox, self.general_X, self.general_Y, 0, 1, 1, self.oX, self.oY)

		-- Text
		love.graphics.setColor(self.typewriter_r, self.typewriter_g, self.typewriter_b, self.typewriter_a)
 
		if self.nameLabel_name == nil then
			love.graphics.print(
				self.typewriter_shownText,
				FacilTextbox_class.typewriter_font,
				((self.general_X - self.oX) + 9),
				((self.general_Y - self.oY) + 9)
			)
		else
			love.graphics.print(
				self.typewriter_shownText,
				FacilTextbox_class.typewriter_font,
				((self.general_X - self.oX) + 9),
				((self.general_Y - self.oY) + 15)
			)
		end
		love.graphics.setColor(1, 1, 1, 1)

		-- Indicator
		if self.indicator_isShowing then
			love.graphics.draw(
				self.indicator_image,
				self.indicator_quads[self.indicator_index],
				self.general_X + math.floor(95),
				self.general_Y + math.floor(20)
			)
		end

		-- Name
		if self.nameLabel_name ~= nil then
			love.graphics.setColor(self.nameLabel_r, self.nameLabel_g, self.nameLabel_b, self.nameLabel_a)

			if self.general_isAtBottom then
				love.graphics.print(
					self.nameLabel_name .. ":",
					FacilTextbox_class.typewriter_font,
					(self.general_X - self.oX) + 9,
					(self.general_Y - self.oY) + 6
				)
			else
				love.graphics.print(
					self.nameLabel_name .. ":",
					FacilTextbox_class.typewriter_font,
					(self.general_X - self.oX) + 9,
					(self.general_Y - self.oY) + 6
				)
			end
			love.graphics.setColor(1, 1, 1, 1)
		end
	end
end

--Constructor

local metaBox = {}
metaBox.__index = FacilTextbox_class

function FacilTextbox_class.new(bottom, typewriter_speed, typewriter_lines, r, g, b, a, speaker)
	local textInstance = setmetatable({}, metaBox)

	textInstance.general_isAtBottom = bottom == true
	textInstance.typewriter_speed = typewriter_speed or 2
	textInstance.typewriter_lines = typewriter_lines or {"Looks to me that this\nis a FacilTextbox", "How cool!\n Let me try."}
	textInstance.typewriter_r = r or 1
	textInstance.typewriter_g = g or 1
	textInstance.typewriter_b = b or 1
	textInstance.typewriter_a = a or 1
	textInstance.nameLabel_name = speaker or nil
	return textInstance
end

return FacilTextbox_class