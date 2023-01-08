extends TileMap


@export var nextLevel: PackedScene

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

func can_plant(search_position):
	return get_cell_tile_data(0, local_to_map(search_position)).get_custom_data('Plantable')

func get_plant_spot(search_position, offset = Vector2i(0,0)):
	return map_to_local(local_to_map(search_position) + offset)

func next_level():
	if nextLevel != null:
		Global.hud.new_level()
		get_tree().change_scene_to_packed(nextLevel)

func _process(_delta):
	if Input.is_action_just_pressed('reload'):
		get_tree().reload_current_scene()
