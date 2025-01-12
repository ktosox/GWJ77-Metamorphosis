extends Node3D

var placed_part_scene : PackedScene

var valid_materials = [preload("res://experimental/checkerboard_material.tres"),preload("res://experimental/gradient_material.tres"),preload("res://experimental/grid_material.tres")]

func swap_placed_object(part : Node3D) -> void:
	placed_part_scene.instantiate()
	pass

func swap_central_body(new_body : Node3D) -> void:
	$ObjectHolder.get_child(0).queue_free()
	$ObjectHolder.add_child(new_body)
	await get_tree().create_timer(0.3).timeout
	swap_material(randi()%3)
	pass

func swap_material(material_ID : int) -> void:
	print(valid_materials[material_ID])

	$ObjectHolder.get_child(0).get_node("Mesh").set_surface_override_material(0,valid_materials[material_ID])

	pass


func update_preview() -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	$Camera3D/RayCast3D.look_at($Camera3D.project_position(mouse_pos,50))
	$Camera3D/RayCast3D.force_raycast_update()
	$ColisionPreview.global_position = $Camera3D/RayCast3D.get_collision_point()
	
func _on_timer_timeout() -> void:
	update_preview()
	if $Camera3D/RayCast3D.is_colliding():
		
		$ColisionPreview.visible = true
	else:
		$ColisionPreview.visible = false
	pass # Replace with function body.
