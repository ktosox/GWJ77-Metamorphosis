extends Node3D

var placed_object : MeshInstance3D

var valid_materials = [preload("res://experimental/checkerboard_material.tres"),preload("res://experimental/gradient_material.tres"),preload("res://experimental/grid_material.tres")]

func place_object(part = placed_object) -> void:
	if part == null:
		return
	$ObjectHolder/ExampleBodyB
	placed_object.get_node("Body").collision_layer = $ObjectHolder/ExampleBodyB.collision_layer
	placed_object.reparent($ObjectHolder.get_child(0))
	pass

func swap_placed_object(new_part : MeshInstance3D) -> void:
	placed_object = new_part
	if $ColisionPreview.get_child_count() > 0:
		$ColisionPreview.get_child(0).queue_free()
	$ColisionPreview.add_child(new_part)

	# update the mesh under preview here
	pass

func swap_central_body(new_body : Node3D) -> void:
	$ObjectHolder.get_child(0).queue_free()
	$ObjectHolder.add_child(new_body)
	#await get_tree().create_timer(0.3).timeout
	#swap_material(randi()%3)
	pass

#func swap_material(material_ID : int) -> void:
	#print(valid_materials[material_ID])
#
	#$ObjectHolder.get_child(0).get_node("Mesh").set_surface_override_material(0,valid_materials[material_ID])
#
	#pass


func update_preview() -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	$Camera3D/RayCast3D.look_at($Camera3D.project_position(mouse_pos,50))
	$Camera3D/RayCast3D.force_raycast_update()
	$ColisionPreview.global_position = $Camera3D/RayCast3D.get_collision_point()
	if $Camera3D/RayCast3D.is_colliding():
		
		$ColisionPreview.visible = true
	else:
		$ColisionPreview.visible = false
	if $Camera3D/RayCast3D.get_collider() != null:
		$ColisionPreview.global_rotation = Vector3.UP.bounce($Camera3D/RayCast3D.get_collision_normal()) # $ObjectHolder.global_rotation 
	
	
