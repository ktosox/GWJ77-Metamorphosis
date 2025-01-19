extends CPUParticles3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rotate(Vector3.UP,deg_to_rad(90*(randi()%4) ))

	global_position += Vector3(0,0,-1.9).rotated(Vector3.UP,rotation.y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
