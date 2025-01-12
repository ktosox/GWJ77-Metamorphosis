extends RigidBody3D

const MOVE_FORCE = 10.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	
	
	var input_dir := Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	apply_central_force(direction * MOVE_FORCE)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	print(linear_velocity)
	pass # Replace with function body.


func _on_body_entered(body: Node) -> void:
	print(body)

	pass # Replace with function body.
