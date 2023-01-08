extends Node

var camera
var player
var tileMap
var hud

enum PLANT_TYPES {
	VINE,
	MUSHROOM,
	TREE,
}

var plantTypes = {
	PLANT_TYPES.VINE: 'vine',
	PLANT_TYPES.MUSHROOM: 'mushroom',
	PLANT_TYPES.TREE: 'tree',
}

var plantIcons = {
	PLANT_TYPES.VINE: 67,
	PLANT_TYPES.MUSHROOM: 128,
	PLANT_TYPES.TREE: 0,
}

var COLLISION_FLAGS = {} :
	get:
		var flags = {}
		var seq = 1
		for _i in range(1,32):
			if _i > 1:
				seq = seq * 2
			flags[ProjectSettings.get_setting("layer_names/2d_physics/layer_" + str(_i)).to_upper()] = seq

		return flags

func is_active_plant(plant_type):
	return int(str(plant_type)) == hud.selected

func plant_type_to_frame(plant_type):
	return Global.plantIcons[int(str(plant_type))]

func count_to_frame_coords(plant_type):
	var count = 0
	if (Global.player != null):
		count = Global.player.seeds[int(str(plant_type))]

	var x = count
	var y = 8

	return Vector2i(x, y)
