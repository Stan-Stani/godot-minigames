extends TileMapLayer

const BOTTOM = 14

var noise = FastNoiseLite.new()


func _ready() -> void:
	generate_map()

func generate_map():
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.seed = randi()
	noise.frequency = .3

	for x in range(100):
		var noise_value: float = noise.get_noise_1d(x)
		# scale to 0 to -1 instead of -1 to 1
		# print(noise_value)
		noise_value = - abs(noise_value)
		var noise_scaled = noise_value * 20
		var noise_scaled_int = int(noise_scaled)

		var atlas_coords = Vector2i(0, 0)


		for y in range(abs(noise_scaled_int) + 1):
			var tile_pos = Vector2i(x, -y + BOTTOM)
			print(tile_pos)
			self.set_cell(tile_pos, 0, atlas_coords)
			var desc = Label.new()
			desc.scale = Vector2(.5, .5)
			desc.text = str(tile_pos.x) + ', ' + str(tile_pos.y)
			desc.position = Vector2i(tile_pos.x * 16, tile_pos.y * 16)
			self.add_sibling.call_deferred(desc)
