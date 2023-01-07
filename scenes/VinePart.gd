extends Sprite2D

var spawned = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func grow():
	var index = frames.find(frame)
	if index < frames.size() - 1:
		frame = frames[index + 1]
	elif not spawned:
		spawned = true
		plant = duplicate()
		node.frame = frames[0]
		plant.position = position
		get_parent().add_child(plant)
