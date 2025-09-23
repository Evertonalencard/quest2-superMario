extends Area2D

class_name  Enemy

@export var horizontal_spead = 20
@export var vertical_spead = 100
@onready var ray_cast_2d = $RayCast2D as RayCast2D

#teste

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x -= horizontal_spead * delta
	
	if !ray_cast_2d.is_colliding():
		position.y += vertical_spead * delta
