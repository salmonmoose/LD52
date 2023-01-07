extends Node

var plant_type : Global.PLANT_TYPES
var count = 0

@onready var icon = $SeedIcon
@onready var countSprite = $SeedCount

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	icon.frame = Global.plant_type_to_frame(name)
	countSprite.frame_coords = Global.count_to_frame_coords(name)
	
