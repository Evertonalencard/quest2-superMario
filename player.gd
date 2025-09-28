extends CharacterBody2D

class_name Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

enum PlayerMode{
	SMALL,
	BIG,
	SHOOTING
}

signal points_scored(points: int)

const POINTS_LABEL_SCENE = preload("res://points_label.tscn")

@export_group("Stomping Enemies")
@export var min_stomp_degree = 35
@export var max_stomp_degree = 145
@export var stomp_y_velocity =-150
@export_group("")

@onready var animated_sprite_2d = $AnimatedSprite2D as PlayerAnimatedSprite
@onready var area_collision_shape_2d =$Area2D/AreaColisionShape
@onready var player_collision_Shape_2d = $PlayerColisionShape
@onready var area_2d = $Area2D

@export_group("Locomotion")
@export var run_spead_damping = 8.0
@export var spead = 100.0
@export var jump_velocity = -400.0
@export_group("")

var player_mode = PlayerMode.SMALL
var is_dead = false

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
	if area is Enemy:
		handle_enemy_colision(area)
		
func handle_enemy_colision(enemy: Enemy):
	if enemy ==null || is_dead:
		return
	if is_instance_of(enemy, KOOPA) and (enemy as KOOPA).in_a_shell:
		(enemy as KOOPA).on_stomp(global_position)
	else :
		var engle_of_colision = rad_to_deg(position.engle_to_point(enemy.position))
		
		if engle_of_colision >min_stomp_degree && max_stomp_degree > engle_of_colision:
			enemy.die()
			on_enemy_stomped()
			spawn_points_label(enemy)
		else:
			die()

	
func on_enemy_stomped():
	velocity.y = stomp_y_velocity
	
func spawn_points_label(enemy):
	var points_label = POINTS_LABEL_SCENE.instantiate()
	points_label.position = enemy.position + Vector2(-20,-20)
	get_tree().root.add_child(points_label)
	points_scored.emit(100)
	
func die():
	if player_mode == player_mode.small:
		is_dead = true
		animated_sprite_2d.play("small_death")
		set_physics_process(false)
		
		var death_tween = get_tree().create_tween()
		death_tween.tween_property(self,"position", position + Vector2(0, -48), .5)
		death_tween.chain().tween_property(self, "position", position + Vector2(0, 256), 1)
		death_tween.tween_callback(func(): get_tree().reload_current_scene())
