extends Control

var current_game_level : Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#start_game()
	pass # Replace with function body.



# SPECILA TEST BUTTONS

#func _on_button_1_pressed() -> void:
	#test_load_level(1)
	#pass # Replace with function body.
#
#func _on_button_2_pressed() -> void:
	#test_load_level(2)
	#pass # Replace with function body.
#
#func _on_button_3_pressed() -> void:
	#test_load_level(3)
	#pass # Replace with function body.



func start_game() -> void:
	$PanelTexture/Layout/SelectLevelButton.visible = true
	$PanelTexture/Layout/OptionsWindowButton.visible = true
	$SelectLevel.visible = true
	$OptionsWindow.visible = true
	#$StartAniamator.stop()
	$StartAniamator.play("loop")
	pass


func _on_select_level_button_pressed() -> void:
	$SelectLevel.visible = !$SelectLevel.visible

	pass # Replace with function body.




func _on_game_window_button_pressed() -> void:
	$GameWindow.visible = !$GameWindow.visible

	pass # Replace with function body.


func _on_hidden_window_button_pressed() -> void:
	$HiddenWindow.visible = !$HiddenWindow.visible
	pass # Replace with function body.


func _on_options_window_button_pressed() -> void:
	$OptionsWindow.visible = !$OptionsWindow.visible
	pass # Replace with function body.


func _on_path_selection_screen_create_new_level(level_data: LevelData) -> void:
	GM.emit_signal("falling_started")
	if current_game_level!=null:
		current_game_level.queue_free()
	
	var new_level = load("res://level/level_builder.tscn").instantiate()
	#add funy things to new_level based on a level_number match HERE
	current_game_level = new_level
	new_level.data = level_data
	#knobs to turn here: @export_range(1,3) var world (from 1 to 3), @export var segment_count = 6 (how long should the fall be?), @export var feature_list : Array (bonus things to add)
	new_level.connect("level_complete",Callable(self,"end_level"))
	$GameWindow.add_child(new_level)
	$GameWindow.visible = true
	$GameWindow.grab_focus()
	
	$GameWindow/CenterContainer.visible = false
	if !$PanelTexture/Layout/GameWindowButton.visible:
		$PanelTexture/Layout/GameWindowButton.visible = true
	# code for passing on level creation data to $GameWindow goes here
	pass # Replace with function body.


func end_level(new_time : float) -> void:
	GM.player_time = new_time
	GM.emit_signal("falling_ended")
	$GameWindow.visible = false
	$GameWindow/CenterContainer.visible = true
	$SelectLevel/PathSelectionScreen.generate_new_paths()
	if !$HiddenWindow.visible:
		$HiddenWindow.visible = true
		$PanelTexture/Layout/HiddenWindowButton.visible = true
		$Welcome2.play("new_animation")
	pass
