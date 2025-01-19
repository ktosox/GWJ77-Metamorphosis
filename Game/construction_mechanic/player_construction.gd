extends HBoxContainer

var selected_body : Node3D

var selected_material : StandardMaterial3D

var selected_part : PartData

var _part_selection_button_scene = preload("res://construction_mechanic/part_selection_button.tscn")

@onready var parts_go_here = $PartSelector/GridContainer

@onready var tips_go_here = $ColorRect/PlayerTips

@onready var player_builder = $ConstructionWindow/SubViewport/PlayerBuildingTest


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_part(GM.get_part_type_data(0,0))
	add_part(GM.get_part_type_data(1,0))
	add_part(GM.get_part_type_data(2,0))
	add_part(GM.get_part_type_data(2,1))
	add_part(GM.get_part_type_data(2,1))
	#await get_tree().create_timer(1).timeout
	#send_player_tip("Hello world, derp derp derp herp derp. manymany words go here")
	pass # Replace with function body.

	
	
func add_part(data : PartData) -> void:
	var new_part = _part_selection_button_scene.instantiate()
	new_part.data = data
	new_part.connect("part_selected",Callable(self,"player_chose_part"))
	parts_go_here.add_child(new_part)

	pass

func remove_part(data : PartData) -> void:
	
	pass

func player_chose_part(data : PartData) -> void:
	if GM.has_skill_level(data.required_skill,data.required_level):
		# this is a valid part selection
		
		#$ConstructionWindow/SubViewport/PlayerBuildingTest - change object over here
		var mesh_scene = data.mesh_scene.instantiate()
		mesh_scene.set_meta("experience",data.experience_points)
		player_builder.swap_placed_part(mesh_scene)
		selected_part = data

		$ColorRect/SpecialPreviewWindow/PartPreview.visible = true
		$ColorRect/SpecialPreviewWindow/PartPreview.load_part_data(data)
		
		pass
	else:
		send_player_tip("You don't have the required skill to use this part")
		# this is not valid part selection
		# send negative message to tips_go_here
		pass

	pass

func send_player_tip(tip_text : String) -> void:
	$ColorRect/PlayerTips.text = tip_text
	$ColorRect/PlayerTips/AniamteTip.stop()
	$ColorRect/PlayerTips/AniamteTip.play("new_animation")
	pass

func _on_shape_button_a_pressed() -> void:
	#selected_body = body_A_scene.instantiate()
	#$ConstructionWindow/SubViewport/PlayerBuildingTest.swap_central_body(selected_body)
	pass # Replace with function body.


func _on_shape_button_b_pressed() -> void:
	#selected_body = body_B_scene.instantiate()
	#$ConstructionWindow/SubViewport/PlayerBuildingTest.swap_central_body(selected_body)
	pass # Replace with function body.


func _on_texture_1_pressed() -> void:
	#$ConstructionWindow/SubViewport/PlayerBuildingTest.swap_material(0)
	pass # Replace with function body.


func _on_texture_2_pressed() -> void:
	#$ConstructionWindow/SubViewport/PlayerBuildingTest.swap_material(1)
	pass # Replace with function body.


func _on_texture_3_pressed() -> void:
	#$ConstructionWindow/SubViewport/PlayerBuildingTest.swap_material(2)
	pass # Replace with function body.


func _on_parts_button_pressed() -> void:
	$PartSelector.visible = true
	$SkillPoints.visible = false
	$MorphingScreen.visible = false
	send_player_tip("Select a part and attach it with left click")
	pass # Replace with function body.
	
	
func _on_morph_button_pressed() -> void:
	$PartSelector.visible = false
	$SkillPoints.visible = false
	$MorphingScreen.visible = true
	$ColorRect/SpecialPreviewWindow/PartPreview.visible = false
	send_player_tip("Morph here to advance and reset skill points")
	pass # Replace with function body.

func _on_skills_button_pressed() -> void:
	$PartSelector.visible = false
	$SkillPoints.visible = true
	$MorphingScreen.visible = false
	$ColorRect/SpecialPreviewWindow/PartPreview.visible = false
	send_player_tip("This is where you can gain skills")
	pass # Replace with function body.




func _on_transform_button_pressed() -> void:
	# add check if transformation can occur
	$MorphingScreen/TransformButton.disabled = true
	for button in $ColorRect/ScreenSelection.get_children():
		button.disabled = true
		pass
	var experience_gained = await $ConstructionWindow/SubViewport/PlayerBuildingTest.consume_placed_parts()
	
	GM.transform_player(experience_gained)
	$MorphingScreen/TransformButton.disabled = false
	for button in $ColorRect/ScreenSelection.get_children():
		button.disabled = false
		pass
	pass # Replace with function body.


func _on_construction_window_part_was_placed() -> void:
	$ColorRect/SpecialPreviewWindow/PartPreview.visible = false
	if selected_part.bonus_property != PartData.Special_Property.NONE:
		GM.player_bonus_properties[selected_part.bonus_property] += 1
	print(GM.player_bonus_properties)
	for part in parts_go_here.get_children():
		if part.data == selected_part:
			part.queue_free()
			return
	pass # Replace with function body.
