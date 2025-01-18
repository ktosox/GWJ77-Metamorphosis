extends HBoxContainer

var selected_body : Node3D

var selected_material : StandardMaterial3D

var selected_part : Node3D

var _part_selection_button_scene = preload("res://construction_mechanic/part_selection_button.tscn")

@onready var parts_go_here = $PartSelector/GridContainer

@onready var tips_go_here = $ColorRect/PlayerTips

@onready var player_builder = $ConstructionWindow/SubViewport/PlayerBuildingTest

@export var starting_parts : Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for part in starting_parts:
		add_part(part)
	#await get_tree().create_timer(1).timeout
	#send_player_tip("Hello world, derp derp derp herp derp. manymany words go here")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func add_part(data : PartData) -> void:
	var new_part = _part_selection_button_scene.instantiate()
	new_part.data = data
	new_part.connect("part_selected",Callable(self,"player_chose_part"))
	parts_go_here.add_child(new_part)

	pass


func player_chose_part(data : PartData) -> void:
	if GM.has_skill_level(data.required_skill,data.required_level):
		# this is a valid part selection
		
		#$ConstructionWindow/SubViewport/PlayerBuildingTest - change object over here
		player_builder.swap_placed_object(data.mesh_scene.instantiate())
		pass
	else:
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
	send_player_tip("Select a part and attach it with left click")
	pass # Replace with function body.


func _on_skills_button_pressed() -> void:
	$PartSelector.visible = false
	$SkillPoints.visible = true
	send_player_tip("This is where you can gain skills")
	pass # Replace with function body.
