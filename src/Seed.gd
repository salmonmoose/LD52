extends Area2D

@onready var collision = $Collision
@onready var animation = $Animation
@onready var audioPlayer = $AudioPlayer

@export var plant_type : Global.PLANT_TYPES
@export var audioStream : AudioStream

signal seed_collected(plant_type)

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play('seed_animation')

	pass # Replace with function body.

func _on_body_entered(body):
	body.add_seed(plant_type)
	body.audioPlayer.stream = audioStream
	body.audioPlayer.play()

	queue_free()
