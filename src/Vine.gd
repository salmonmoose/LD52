extends Node2D

var frames = [
	144,
	124,
	125,
	145,
]

@onready var parts = $Parts
@onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func grow():
	var children = parts.get_children()
	if children.size() < 5:
		for _i in children:
			var index = frames.find(_i.frame)

			if index < frames.size() - 1:
				_i.frame = frames[index + 1]
				if _i.frame == 145:
					var plant = _i.duplicate()
					parts.add_child(plant)
					plant.frame = frames[0]
					plant.position.y -= 16


func _on_timer_timeout():
	grow()
