extends Camera3D


@export var move_speed = 8.0

func _process(delta: float) -> void:
	
	var input_dir := Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	var direction = Vector3(input_dir.x,0,input_dir.y)
	global_position += direction * delta * move_speed
	
	pass
