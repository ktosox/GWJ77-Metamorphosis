extends HBoxContainer

var selected_body : Node3D

var selected_material : StandardMaterial3D

var selected_part : Node3D

var body_A_scene = preload("res://experimental/example_body_a.tscn")

var body_B_scene = preload("res://experimental/example_body_b.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_spike_button_pressed() -> void:
	selected_part
	pass # Replace with function body.


func _on_box_button_pressed() -> void:
	pass # Replace with function body.


func _on_can_button_pressed() -> void:
	pass # Replace with function body.


func _on_shape_button_a_pressed() -> void:
	selected_body = body_A_scene.instantiate()
	$ConstructionWindow/SubViewport/PlayerBuildingTest.swap_central_body(selected_body)
	pass # Replace with function body.


func _on_shape_button_b_pressed() -> void:
	selected_body = body_B_scene.instantiate()
	$ConstructionWindow/SubViewport/PlayerBuildingTest.swap_central_body(selected_body)
	pass # Replace with function body.


func _on_texture_1_pressed() -> void:
	$ConstructionWindow/SubViewport/PlayerBuildingTest.swap_material(0)
	pass # Replace with function body.


func _on_texture_2_pressed() -> void:
	$ConstructionWindow/SubViewport/PlayerBuildingTest.swap_material(1)
	pass # Replace with function body.


func _on_texture_3_pressed() -> void:
	$ConstructionWindow/SubViewport/PlayerBuildingTest.swap_material(2)
	pass # Replace with function body.
