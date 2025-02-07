extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: RigidBody3D) -> void:
	if body.is_in_group("Player"):
		$MeshInstance3D.visible = false
		$CPUParticles3D.emitting = true
		set_deferred("monitoring",false)
	body.apply_central_impulse(Vector3(0,5,0))
	pass # Replace with function body.
