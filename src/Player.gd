extends CharacterBody2D

const SPEED = 75.0
const JUMP_VELOCITY = -180.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var vine = preload("res://scenes/Vine.tscn")

@onready var animation = $Animation
@onready var sprite = $Sprite
@onready var plantSpot = $PlantSpot
@onready var raycast = $RayCast2D

var plants = {
	Global.PLANT_TYPES.VINE: vine
}

var seeds = {}

func _init():
	Global.player = self
	print(Global.player)

func _process(delta):
	if seeds.size() > 0:
		plantSpot.visible = true

		if is_on_floor():
			plantSpot.frame = 32
		else:
			plantSpot.frame = 31

		plantSpot.global_position = Global.tileMap.get_plant_spot(raycast.get_collision_point(), Vector2i(0,0))
	else:
		plantSpot.visible = false

	if Input.is_action_just_pressed("player_plant") and is_on_floor() and seeds[Global.hud.selected] > 0:
		var plant = plants[Global.hud.selected].instantiate()

		Global.tileMap.add_child(plant)
		plant.global_position = Global.tileMap.get_plant_spot(raycast.get_collision_point(), Vector2i(0,-1))

		seeds[Global.hud.selected] -= 1
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("player_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Handle movement.
	var direction = Input.get_axis("player_left", "player_right")
	if direction:
		if direction < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false

		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if (velocity.y == 0):
		if (abs(velocity.x) < SPEED / 10):
			animation.play("idle")
		else:
			animation.play("walk")
	elif (velocity.y < 0):
		animation.play("jump")
	else:
		animation.play("fall")

	move_and_slide()


func add_seed(plant_type):
	if seeds.has(plant_type):
		seeds[plant_type] += 1
	else:
		seeds[plant_type] = 1

