extends CharacterBody3D

const FALL_SPEED = -0.8
const SPEED = 2.0

func _physics_process(delta: float) -> void:

	


	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	velocity.y = FALL_SPEED
	if Input.is_action_pressed("ui_accept"):
		velocity.y = 0
	move_and_slide()
