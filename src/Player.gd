extends CharacterBody2D

const SPEED = 75.0
const JUMP_VELOCITY = -180.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var vine = preload("res://scenes/vine.tscn")
var mushroom = preload("res://scenes/mushroom.tscn")
var climbing = false

@onready var animation = $Animation
@onready var sprite = $Sprite
@onready var plantSpot = $PlantSpot
@onready var raycast = $RayCast2D
@onready var bodyArea = $BodyArea
@onready var audioPlayer = $AudioPlayer

var plants = {
	Global.PLANT_TYPES.VINE: vine,
	Global.PLANT_TYPES.MUSHROOM: mushroom,
}

var seeds = {}

func _init():
	Global.player = self

func _process(delta):
	if seeds.size() > 0:
		plantSpot.visible = true

		if can_plant():
			plantSpot.frame = 32
		else:
			plantSpot.frame = 71

		plantSpot.global_position = Global.tileMap.get_plant_spot(raycast.get_collision_point(), Vector2i(0,0))
	else:
		plantSpot.visible = false

	if Input.is_action_just_pressed("player_plant") and can_plant() and Global.hud.selected != null and seeds[Global.hud.selected] > 0:
		var plant = plants[Global.hud.selected].instantiate()

		Global.tileMap.add_plant(plant)
		plant.global_position = Global.tileMap.get_plant_spot(raycast.get_collision_point(), Vector2i(0,-1))

		seeds[Global.hud.selected] -= 1
		
func can_plant():
	return is_on_floor() and Global.tileMap.can_plant(raycast.get_collision_point())

func _physics_process(delta):
	if not is_on_climbable():
		climbing = false

	# Add the gravity.
	if not is_on_floor() and not climbing:
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("player_jump") and (is_on_floor() or is_on_climbable()):
		climbing = false
		velocity.y = JUMP_VELOCITY

	if is_on_climbable():
		var vertical_direction = Input.get_axis("player_up", "player_down")
		if vertical_direction:
			climbing = true
			velocity.y = vertical_direction * SPEED
		elif climbing:
			velocity.y = move_toward(velocity.y, 0, SPEED)
		

	# Handle movement.
	var horizontal_direction = Input.get_axis("player_left", "player_right")
	if horizontal_direction:
		if horizontal_direction < 0:
			sprite.flip_h = true
		else:
			sprite.flip_h = false

		velocity.x = horizontal_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if (velocity.y == 0):
		if (abs(velocity.x) < SPEED / 10):
			animation.play("idle")
		else:
			animation.play("walk")

	elif is_on_climbable():
		animation.play("climb")

	elif (velocity.y < 0):
		animation.play("jump")

	else:
		animation.play("fall")

	move_and_slide()

func get_collision_layers():
	var mask = 0
	for _i in bodyArea.get_overlapping_areas():
		if _i.get_class() == "Area2D":
			mask |= _i.get_collision_layer()

	return mask

func is_flag(flag):
	return get_collision_layers() & flag > 0

func is_on_climbable():
	return is_flag(Global.COLLISION_FLAGS.CLIMBABLE)

func add_seed(plant_type):
	if seeds.has(plant_type):
		seeds[plant_type] += 1
	else:
		seeds[plant_type] = 1

