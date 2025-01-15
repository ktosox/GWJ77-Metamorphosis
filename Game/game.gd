extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func test_load_level(level_number : int):
	$GameWindow.get_child(0).queue_free()
	var new_level = load("res://level/level_builder.tscn").instantiate()
	#add funy things to new_level based on a level_number match HERE
	
	#knobs to turn here: @export_range(1,3) var world (from 1 to 3), @export var segment_count = 6 (how long should the fall be?), @export var feature_list : Array (bonus things to add)
	new_level.world = level_number
	new_level.segment_count = 3+level_number
	$GameWindow.add_child(new_level)
	$GameWindow.visible = true
	$GameWindow.grab_focus()
	if !$PanelTexture/Layout/GameWindowButton.visible:
		$PanelTexture/Layout/GameWindowButton.visible = true
	pass


# SPECILA TEST BUTTONS

func _on_button_1_pressed() -> void:
	test_load_level(1)
	pass # Replace with function body.

func _on_button_2_pressed() -> void:
	test_load_level(2)
	pass # Replace with function body.

func _on_button_3_pressed() -> void:
	test_load_level(3)
	pass # Replace with function body.


# WINDOW MINIMAZING STUFF

func _on_select_level_close_requested() -> void:
	$SelectLevel.visible = false
	
	pass # Replace with function body.


func _on_select_level_button_pressed() -> void:
	$SelectLevel.visible = !$SelectLevel.visible

	pass # Replace with function body.


func _on_game_window_close_requested() -> void:
	$GameWindow.visible = false
	pass # Replace with function body.


func _on_game_window_button_pressed() -> void:
	$GameWindow.visible = !$GameWindow.visible

	pass # Replace with function body.


func _on_hidden_window_button_pressed() -> void:
	$HiddenWindow.visible = !$HiddenWindow.visible
	pass # Replace with function body.


func _on_hidden_window_close_requested() -> void:
	$HiddenWindow.visible = false
	pass # Replace with function body.
