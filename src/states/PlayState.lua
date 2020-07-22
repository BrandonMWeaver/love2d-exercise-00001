PlayState = Class{__includes = BaseState}

function PlayState:enter(params)
	tileGenerator = TileGenerator({ 'graphics/tile-1.png', 'graphics/tile-2.png' })
	tileGenerator.randomization = true
	self.tiles = tileGenerator:generateTiles(0, 0)

	self.isPaused = false
end

function PlayState:update(dt)
	if love.keyboard.wasPressed('p') then
		self.isPaused = not self.isPaused
	end

	if love.keyboard.wasPressed('escape') then
		gStateMachine:change('start', { title = 'EXAMPLE TITLE' })
	end
	
	if not self.isPaused then
		for k, tile in pairs(self.tiles) do
			if tile.y > VIRTUAL_HEIGHT then
				tile.y = -tileGenerator.height + 1
			end

			if tile.y <= -tileGenerator.height then
				tile.y = VIRTUAL_HEIGHT
			end

			if tile.x > VIRTUAL_WIDTH then
				tile.x = -tileGenerator.width + 1
			end

			if tile.x <= -tileGenerator.width then
				tile.x = VIRTUAL_WIDTH
			end
		end

		if love.keyboard.isDown('w') or love.keyboard.isDown('up') then
			for k, tile in pairs(self.tiles) do
				tile.y = tile.y + 1
			end
		elseif love.keyboard.isDown('s') or love.keyboard.isDown('down') then
			for k, tile in pairs(self.tiles) do
				tile.y = tile.y - 1
			end
		end

		if love.keyboard.isDown('a') or love.keyboard.isDown('left') then
			for k, tile in pairs(self.tiles) do
				tile.x = tile.x + 1
			end
		elseif love.keyboard.isDown('d') or love.keyboard.isDown('right') then
			for k, tile in pairs(self.tiles) do
				tile.x = tile.x - 1
			end
		end
	end
end

function PlayState:render()
	for k, tile in pairs(self.tiles) do
		love.graphics.draw(tile.image, tile.x, tile.y)
	end

	if not self.isPaused then
		drawDisplay()
	else
		love.graphics.print('PAUSED', 5, 5)
	end
end

function drawDisplay()
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.print('Tiling Demonstration', 5, 5)
	love.graphics.print('Brandon M Weaver', 5, 25)
	love.graphics.print(tostring(love.timer.getTime()), 5, 45)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 65)
	love.graphics.setColor(255, 255, 255, 255)
end