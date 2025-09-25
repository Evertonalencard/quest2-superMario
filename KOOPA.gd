extends Enemy
class_name KOOPA 
 
const KOOPA_FULL_SHAPE = preload("res://Resorces/ColisionShapes/koopa_full.tres")
const KOOPA_SHELL_SHAPE = preload("res://Resorces/ColisionShapes/koopa_shell.tres")
const KOOPA_SHELL_POSITION =Vector2(0,5)
@onready var collision_shape_2d
@export var slide_speed = 200
var in_a_shell = false

func _ready():
	collision_shape_2d = KOOPA_FULL_SHAPE
	


func _on_area_entered(area: Area2D) -> void:
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	pass # Replace with function body.
