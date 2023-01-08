extends Area2D

@export var audioStream : AudioStream

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	Global.hud.audioPlayer.stream = audioStream
	Global.hud.audioPlayer.play()
	get_parent().next_level()

