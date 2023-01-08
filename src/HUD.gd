extends CanvasLayer

@onready var seedContainer = $SeedContainer
@onready var audioPlayer = $AudioPlayer

var seedCounter = preload("res://scenes/SeedCounter.tscn")
# Called when the node enters the scene tree for the first time.

var selected = null

func _init():
	Global.hud = self

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

	if selected != null:
		var keys = Global.player.seeds.keys()
		var index = keys.find(selected)
		if Input.is_action_just_pressed('next_seed'):
			if index < keys.size() - 1:
				selected = keys[index + 1]
			else:
				selected = keys[0]

		elif Input.is_action_just_pressed('prev_seed'):
			if index > 0:
				selected = keys[index - 1]
			else:
				selected = keys[keys.size() - 1]

	if Global.player != null:
		for _i in Global.player.seeds:
			if !seedContainer.has_node(str(_i)):
				var counter = seedCounter.instantiate()
				counter.name = str(_i)
				seedContainer.add_child(counter)
				if selected == null: selected = _i


func new_level():
	for _i in seedContainer.get_children():
		_i.queue_free()
