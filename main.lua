require 'src/dependencies'

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	})

	gStateMachine = StateMachine {
		['start'] = function() return StartState() end,
		['play'] = function() return PlayState() end
	}

	gStateMachine:change('start', { title = 'PRESS ENTER TO START' })

	love.keyboard.keysPressed = {}
end

function love.resize(w, h)
	push:resize(w, h)
end

function love.keypressed(key)
	love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
	return love.keyboard.keysPressed[key]
end

function love.update(dt)
	gStateMachine:update(dt)

	love.keyboard.keysPressed = {}
end

function love.draw()
	push:apply('start')

	gStateMachine:render()

	push:apply('end')
end