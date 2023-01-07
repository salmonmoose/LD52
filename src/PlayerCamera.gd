extends Camera2D


func _init():
	Global.camera = self

# Called when the node enters the scene tree for the first time.
func _ready():
	var bounds = Global.tileMap.calculate_bounds()

	self.limit_left = bounds.position.x
	self.limit_right = bounds.end.x

	self.limit_top = bounds.position.y
	self.limit_bottom = bounds.end.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
