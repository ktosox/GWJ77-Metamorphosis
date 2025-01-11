extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	$Camera3D/RayCast3D.look_at($Camera3D.project_position(mouse_pos,50))
	$Camera3D/RayCast3D.force_raycast_update()
	if $Camera3D/RayCast3D.is_colliding():
		$ColisionPreview.global_position = $Camera3D/RayCast3D.get_collision_point()
		$ColisionPreview.visible = true
	else:
		$ColisionPreview.visible = false
	pass # Replace with function body.
