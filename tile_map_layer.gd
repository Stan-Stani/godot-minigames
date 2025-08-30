extends TileMapLayer

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
		noise_value = -abs(noise_value)
		var noise_scaled = noise_value * 20
		print(noise_scaled)
		var tile_pos = Vector2i(x, noise_scaled + 14)
		var atlas_coords = Vector2i(0, 0)

		self.set_cell(tile_pos, 0, atlas_coords)
