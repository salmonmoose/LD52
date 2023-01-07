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
	PLANT_TYPES.MUSHROOM: 0,
	PLANT_TYPES.TREE: 0,
}

func plant_type_to_frame(plant_type):
	return Global.plantIcons[int(str(plant_type))]


func count_to_frame_coords(plant_type):
	var count = Global.player.seeds[int(str(plant_type))]

	var x = count
	var y = 8

	return Vector2i(x, y)
