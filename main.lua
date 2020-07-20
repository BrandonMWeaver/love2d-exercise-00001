require 'src/dependencies'

function love.load()
	love.graphics.setDefaultFilter('nearest', 'nearest')

	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
		vsync = true,
		fullscreen = false,
		resizable = true
	})

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

tileGenerator = TileGenerator({ 'graphics/tile-1.png', 'graphics/tile-2.png' })

blocks = {
	tileGenerator:generateTiles(20, 20, 5, 5),
	tileGenerator:generateTiles(20 * 7, 20, 5, 10),
	tileGenerator:generateTiles(20, 20 * 7, 5, 5)
}

tileGenerator.randomization = true

table.insert(blocks, tileGenerator:generateTiles(20 * 7, 20 * 7, 10, 10))

tiles = {}

for i, block in pairs(blocks) do
	for j, tile in pairs(block) do
		table.insert(tiles, tile)
	end
end

function love.update(dt)
	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end

	for k, tile in pairs(tiles) do
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

	if love.keyboard.isDown('w') then
		for k, tile in pairs(tiles) do
			tile.y = tile.y + 1
		end
	elseif love.keyboard.isDown('s') then
		for k, tile in pairs(tiles) do
			tile.y = tile.y - 1
		end
	end

	if love.keyboard.isDown('a') then
		for k, tile in pairs(tiles) do
			tile.x = tile.x + 1
		end
	elseif love.keyboard.isDown('d') then
		for k, tile in pairs(tiles) do
			tile.x = tile.x - 1
		end
	end

	love.keyboard.keysPressed = {}
end

function love.draw()
	push:apply('start')

	for k, tile in pairs(tiles) do
		love.graphics.draw(tile.image, tile.x, tile.y)
	end

	drawDisplay()

	push:apply('end')
end

function drawDisplay()
	love.graphics.setColor(255, 0, 0, 255)
	love.graphics.print('Tiling Demonstration', 5, 5)
	love.graphics.print('Brandon M Weaver', 5, 25)
	love.graphics.print(tostring(love.timer.getTime()), 5, 45)
	love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 65)
	love.graphics.setColor(255, 255, 255, 255)
end