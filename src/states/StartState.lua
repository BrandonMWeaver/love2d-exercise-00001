StartState = Class{__includes = BaseState}

function StartState:enter(params)
	self.title = params.title
	self.menu = {
		'PLAY',
		'EXIT'
	}
	self.menuIndex = 1
end

function StartState:update(dt)
	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end

	if love.keyboard.wasPressed('return') then
		if self.menuIndex == 1 then
			gStateMachine:change('play')
		elseif self.menuIndex == 2 then
			love.event.quit()
		end
	end

	if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('w') then
		if self.menuIndex == #self.menu then
			self.menuIndex = 1
		else
			self.menuIndex = self.menuIndex + 1
		end
	end

	if love.keyboard.wasPressed('down') or love.keyboard.wasPressed('s') then
		if self.menuIndex == 1 then
			self.menuIndex = #self.menu
		else
			self.menuIndex = self.menuIndex - 1
		end
	end
end

function StartState:render()
	love.graphics.setColor(155, 155, 155, 255)
	love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
	love.graphics.setColor(255, 255, 255, 255)

	love.graphics.print(self.title, 5, 5)

	local verticalMargin = 25

	for k, selection in pairs(self.menu) do
		if k == self.menuIndex then
			love.graphics.setColor(0, 0, 255, 255)
			love.graphics.print('- ' .. selection, 5, verticalMargin)
		else
			love.graphics.setColor(255, 255, 255, 255)
			love.graphics.print(selection, 5, verticalMargin)
		end
		verticalMargin = verticalMargin + 20
	end

	love.graphics.setColor(255, 255, 255, 255)
end