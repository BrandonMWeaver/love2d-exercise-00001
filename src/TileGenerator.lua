TileGenerator = Class{}

function TileGenerator:init(images)
	self.images = {}
	self.randomization = false

	for k, image in pairs(images) do
		self.images[k] = love.graphics.newImage(image)
	end

	self.width = self.images[1]:getWidth()
	self.height = self.images[1]:getHeight()
end

function TileGenerator:generateTiles(x1, y1, rows, columns)
	local x, y = x1 or 0, y1 or 0
	local rows, columns = rows or VIRTUAL_HEIGHT / self.height + 1, columns or VIRTUAL_WIDTH / self.width + 1
	local tiles = {}

	local k = 1
	
	for i = 1, rows do
		for j = 1, columns do
			tiles[k] = self:generateTile(k, x, y)
			k = k + 1
			x = x + self.width
			j = j + 1
		end
		x = x1
		y = y + self.height
		i = i + 1
	end

	return tiles
end

function TileGenerator:generateTile(index, x, y)
	return {
		image = self.randomization and self:getRandomImage() or self:getNextImage(index),
		x = x,
		y = y
	}
end

function TileGenerator:getRandomImage()
	return self.images[math.random(#self.images)]
end

function TileGenerator:getNextImage(index)
	return self.images[index % #self.images + 1]
end