extends Enemy
<<<<<<< HEAD

=======
class_name GOOMBA
>>>>>>> 2f83e17db3da6721d7c3d0d5dee8ee11bbc92a94


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func die():
	super.die()
	set_collision_layer_value(3, false)
	set_collision_layer_value(1, false)
	get_tree().create_timer(0.5).timeout.connect(queue_free)
