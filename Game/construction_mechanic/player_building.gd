extends Node3D

var placed_object : MeshInstance3D

var valid_materials = [preload("res://experimental/checkerboard_material.tres"),preload("res://experimental/gradient_material.tres"),preload("res://experimental/grid_material.tres")]

var current_material_ID = 0

var all_placed_parts : Array

func place_part(part = placed_object) -> bool:
	if part == null:
		return false
	$PlacePart.play()
	part.get_node("Body").collision_layer = $ObjectHolder.get_child(0).collision_layer
	part.reparent($ObjectHolder.get_child(0))
	all_placed_parts.push_back(part)
	placed_object = null
	return true

func swap_placed_part(new_part : MeshInstance3D) -> void:
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

func swap_material(material_ID : int) -> void:
	#print(valid_materials[material_ID])
	$ObjectHolder/SmallBallBody/MeshInstance3D.set_surface_override_material(0,valid_materials[material_ID])

#
	#pass
func consume_placed_parts() -> float:
	var total_experience = 0.0

	for part in all_placed_parts:
		total_experience += part.get_meta("experience")
		part.reparent($Consume)

	$Consume/Animator.play("new_animation")
	
	await $Consume/Animator.animation_finished
	for part in all_placed_parts.size():
		all_placed_parts.pop_back().queue_free()

	$Consume/Animator.play("RESET")
	$MorphComplete.play()
	var material_options = [0,1,2]
	material_options.erase(current_material_ID)
	var random_material_ID = material_options[randi()%material_options.size()]
	swap_material(random_material_ID)
	current_material_ID = random_material_ID
	$ObjectHolder/SmallBallBody.scale *= 1.15
	return total_experience


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
	
	
