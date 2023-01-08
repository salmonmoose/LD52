extends NinePatchRect

var plant_type : Global.PLANT_TYPES
var count = 0

@onready var icon = $SeedIcon
@onready var countSprite = $SeedCount

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var active = Rect2(240, 32, 16, 16)
var inactive = Rect2(224, 32, 16, 16)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Global.is_active_plant(name):
		region_rect = active
	else:
		region_rect = inactive

	icon.frame = Global.plant_type_to_frame(name)
	countSprite.frame_coords = Global.count_to_frame_coords(name)
	
