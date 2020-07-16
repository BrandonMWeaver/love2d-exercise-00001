TileGenerator = Class{}

function TileGenerator:init(images, randomization)
	self.images = {}
	self.randomization = randomization or false

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
			tiles[k] = {
				image = self.images[self.randomization and math.random(#self.images) or k % #self.images + 1],
				x = x,
				y = y
			}
			x = x + self.width
			k = k + 1
			j = j + 1
		end
		x = 0
		y = y + self.height
		i = i + 1
	end

	return tiles
end