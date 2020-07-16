TileGenerator = Class{}

function TileGenerator:init(image)
	self.image = love.graphics.newImage(image)
	self.width = self.image:getWidth()
	self.height = self.image:getHeight()
end

function TileGenerator:generateTiles()
	local x, y = 0, 0
	local tiles = {}

	k = 1
	for i = 1, VIRTUAL_HEIGHT / self.height + 1 do
		for j = 1, VIRTUAL_WIDTH / self.width + 1 do
			tiles[k] = {
				image = self.image,
				x = x,
				y = y
			}
			x = x + 20
			k = k + 1
			j = j + 1
		end
		x = 0
		y = y + 20
		i = i + 1
	end

	return tiles
end