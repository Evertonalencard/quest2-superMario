extends CharacterBody2D

class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum PlayerMode{
	SMALL,
	BIG,
	SHOOTING
}

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var area_collision_shape_2d =$Area2D/AreaColisionShape
@onready var player_collision_Shape_2d = $PlayerColisionShape

@export_group("Locomotion")
@export var run_spead_damping = 8.0
@export var spead = 100.0
@export var jump_velocity = -400.0
@export_group("")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_just_released("jump") && velocity.y < 0 :
		velocity.y *= 0.5
	
	var direction = Input.get_axis("left","rigth")
	
	if direction:
		velocity.x = lerp(velocity.x,spead * direction,run_spead_damping * delta)
	else:
		velocity.x = move_toward(velocity.x,0, spead * delta)
	
	move_and_slide()

	
