extends TileMap


func _init():
	Global.tileMap = self

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func calculate_bounds():
	var cell_bounds = Rect2(get_used_rect())
	# create transform
	var cell_to_pixel = Transform2D(
		Vector2(tile_set.tile_size.x * global_scale.x, 0),
		Vector2(0, tile_set.tile_size.y * global_scale.y),
		Vector2()
	)
	# apply transform
	return Rect2(cell_to_pixel * cell_bounds.position, cell_to_pixel * cell_bounds.size)

func get_plant_spot(search_position, offset = Vector2i(0,0)):
	search_position = map_to_local(local_to_map(search_position) + offset)

	return search_position