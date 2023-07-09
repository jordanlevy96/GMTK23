extends TileMap

const MAP_SIZE = Vector2(48, 48)
const LAND_CAP = 0.2
const TREE_CAP = 0.05
const FLOWER_CAP = 0.1
const CLIFF_CAP = 0.1

const tall_tree_coords := [Vector2i(10, 2), Vector2i(9, 2), Vector2i(10, 1)]
var tree_patterns := []

var moisture: FastNoiseLite
var foliage: FastNoiseLite
@export var player: CharacterBody2D

func _ready():
	moisture = FastNoiseLite.new()
	foliage = FastNoiseLite.new()
	moisture.seed = 100 #randi()	
	foliage.seed = 100

	tree_patterns.append(get_pattern(0, tall_tree_coords))
	print(tree_patterns[0].get_used_cells())

func _process(_delta):
	generate_chunk(player.position)

func generate_chunk(pos: Vector2):
	var tile_pos = local_to_map(pos)
	
	var land := []
	var water := []
	for x in MAP_SIZE.x:
		for y in MAP_SIZE.y:
			var tile_x = tile_pos.x-MAP_SIZE.x/2 + x
			var tile_y = tile_pos.y-MAP_SIZE.y/2 + y
			var tile = Vector2i(tile_x, tile_y)
			var m = moisture.get_noise_2d(tile_x, tile_y)
			if m < LAND_CAP:
				land.append(tile)
			else:
				water.append(tile)

	set_cells_terrain_connect(0, water, 0, 0, true)
	set_cells_terrain_connect(0, land, 0, 2, true)

	# var flowers := []
	# var trees := []
	# var cliffs := []
	# for x in MAP_SIZE.x:
	# 	for y in MAP_SIZE.y:
	# 		var tile_x: int = tile_pos.x-MAP_SIZE.x/2 + x
	# 		var tile_y: int = tile_pos.y-MAP_SIZE.y/2 + y
	# 		var tile := Vector2i(tile_x, tile_y)
	# 		if tile in land:
	# 			var f = foliage.get_noise_2d(tile_x, tile_y)
	# 			if f < TREE_CAP:
	# 				trees.append(tile)
	# 			elif f < FLOWER_CAP:
	# 				flowers.append(tile)
	
	# for t in trees:
	# 	# print('setting tree at ', t)
	# 	var p = map_pattern(t, Vector2i(1,1), tree_patterns[0])
	# 	print(p)
	# 	set_pattern(1, t, tree_patterns[0])
