extends TileMap

const MAP_SIZE = Vector2(512, 512)
const LAND_CAP = 0.1

var noise: FastNoiseLite
@export var player: CharacterBody2D

func _ready():
	noise = FastNoiseLite.new()
	noise.seed = 100 #randi()	
	generate_chunk(player.global_position)

func generate_chunk(pos: Vector2):
	var tile_pos = local_to_map(pos)
	
	var land = []
	var water = []
	for x in MAP_SIZE.x:
		for y in MAP_SIZE.y:
			var a = noise.get_noise_2d(x, y)
			if a < LAND_CAP:
				land.append(Vector2(tile_pos.x-MAP_SIZE.x/2 + x, tile_pos.y-MAP_SIZE.y/2 + y))
			else:
				water.append(Vector2(tile_pos.x-MAP_SIZE.x/2 + x, tile_pos.y-MAP_SIZE.y/2 + y))


	set_cells_terrain_connect(0, water, 0, 0, false)
	set_cells_terrain_connect(0, land, 0, 2, true)
