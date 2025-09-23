extends CharacterBody2D

class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum PlayerMode{
	SMALL,
	BIG,
	SHOOTING
}

@export_group("Stomping Enemies")
@export var min_stomp_degree = 35
@export var max_stomp_degree = 145
@export var stomp_y_velocity =-150
@export_group("")


@onready var animated_sprite_2d = $AnimatedSprite2D as PlayerAnimatedSprite
@onready var area_collision_shape_2d =$Area2D/AreaColisionShape
@onready var player_collision_Shape_2d = $PlayerColisionShape

@export_group("Locomotion")
@export var run_spead_damping = 8.0
@export var spead = 100.0
@export var jump_velocity = -400.0
@export_group("")

var player_mode = PlayerMode.SMALL

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
		
	animated_sprite_2d.trigger_animation(velocity, direction, player_mode)
	
	move_and_slide()

	


func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
