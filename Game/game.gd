extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




# SPECILA TEST BUTTONS

func _on_button_1_pressed() -> void:
	$GameWindow.get_child(0).queue_free()
	var new_level = load("res://level/level_builder.tscn").instantiate()
	$GameWindow.add_child(new_level)
	$GameWindow.visible = true
	$GameWindow.grab_focus()
	pass # Replace with function body.

func _on_button_2_pressed() -> void:
	$GameWindow.get_child(0).queue_free()
	var new_level = load("res://level/level_builder.tscn").instantiate()
	$GameWindow.add_child(new_level)
	$GameWindow.visible = true
	$GameWindow.grab_focus()
	pass # Replace with function body.

func _on_button_3_pressed() -> void:
	$GameWindow.get_child(0).queue_free()
	var new_level = load("res://level/level_builder.tscn").instantiate()
	$GameWindow.add_child(new_level)
	$GameWindow.visible = true
	$GameWindow.grab_focus()
	pass # Replace with function body.


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
