StartState = Class{__includes = BaseState}

function StartState:enter(params)
	self.title = params.title
end

function StartState:update(dt)
	if love.keyboard.wasPressed('return') then
		gStateMachine:change('play')
	end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end
end

function StartState:render()
	love.graphics.print(self.title, 5, 5)
end