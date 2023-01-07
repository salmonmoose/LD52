extends CanvasLayer

@onready var seedContainer = $SeedContainer
var seedCounter = preload("res://scenes/SeedCounter.tscn")
# Called when the node enters the scene tree for the first time.

var selected = null

func _init():
	Global.hud = self

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
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