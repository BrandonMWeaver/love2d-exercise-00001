TileGenerator = Class{}

function TileGenerator:init(images)
	self.images = {}
	self.randomization = false
	self.offset = false

	for k, image in pairs(images) do
		self.images[k] = love.graphics.newImage(image)
	end

	self.width = self.images[1]:getWidth()
	self.height = self.images[1]:getHeight()
end

function TileGenerator:generateTiles()
	local x, y = 0, 0
	local tiles = {}

	local k = 1
	
	for i = 1, VIRTUAL_HEIGHT / self.height + 1 do
		for j = 1, VIRTUAL_WIDTH / self.width + 1 do
			tiles[k] = self:generateTile(k, x, y)
			k = k + 1
			x = x + self.width
			j = j + 1
		end
		x = 0
		y = y + self.height
		i = i + 1
	end

	return tiles
end

function TileGenerator:generateTile(index, x, y)
	return {
		image = self.images[self.randomization and self:getRandomImage() or self:getNextImage(index)],
		x = x,
		y = y
	}
end

function TileGenerator:getRandomImage()
	return math.random(#self.images)
end

function TileGenerator:getNextImage(index)
	return index % #self.images + 1
end