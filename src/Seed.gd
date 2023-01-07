extends Area2D

@onready var collision = $Collision
@onready var animation = $Animation

@export var plant_type : Global.PLANT_TYPES

signal seed_collected(plant_type)

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play('seed_animation')

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	body.add_seed(plant_type)

	queue_free()
