extends ColorRect

@onready var buttons_go_here = $Layout/ColorRect/PathSelectionButtonsGoHere

@onready var paths_go_here = $Layout/PathGoHere

var path_details_scene = preload("res://path_mechanic/path_deatils.tscn")

var path_button_scene = preload("res://path_mechanic/path_button.tscn")

signal create_new_level (level_data : LevelData)

@export var possible_feaure_array : Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GM.connect("falling_ended",Callable(self,"end_lock_out"))
	GM.connect("falling_started",Callable(self,"start_lock_out"))
	GM.connect("player_has_transformed",Callable(self,"end_lock_out"))
	GM.connect("player_tranformation_started",Callable(self,"start_lock_out"))
	$Layout/ColorRect/PathSelectionButtonsGoHere/Button.connect("linked_path_requested",Callable(self,"show_this_path"))
	$Layout/PathGoHere/PathDeatils.connect("level_selection_confirmed",Callable(self,"confirm_path_selection"))
	pass # Replace with function body.

func generate_new_paths() -> void:
	# LUL
	for n in 3:
		var new_level_data = LevelData.new()
		new_level_data.desired_length = int(80 + 20 * randf())
		new_level_data.features.push_back(possible_feaure_array[randi()%possible_feaure_array.size()])
		new_level_data.features.push_back(possible_feaure_array[randi()%possible_feaure_array.size()])
		new_level_data.loot_count = 5 + randi()%8
		new_level_data.world = 1 + randi()%3
		create_page(new_level_data)

	pass

func create_page(level_data : LevelData) -> void:
	var random_color = Color(randf()*1.8,randf()*1.8,randf()*1.8)
	
	var new_page = path_details_scene.instantiate() as Control
	
	new_page.level_data = level_data
	new_page.modulate = random_color
	new_page.visible = false
	new_page.connect("level_selection_confirmed",Callable(self,"confirm_path_selection"))
	paths_go_here.add_child(new_page)
	var new_button = path_button_scene.instantiate()
	buttons_go_here.add_child(new_button)
	new_button.linked_path = new_page
	new_button.modulate = random_color
	new_button.connect("linked_path_requested",Callable(self,"show_this_path"))
	pass


func show_this_path(given_path : Control):
	for path in paths_go_here.get_children():
		path.visible = false
	given_path.visible = true
	pass


func confirm_path_selection(level_data : LevelData) -> void:
	
	emit_signal("create_new_level",level_data)
	for path in paths_go_here.get_children():
		path.queue_free()
	for button in buttons_go_here.get_children():
		button.queue_free()

	
	pass



func start_lock_out():
	$LockOutScreen.visible = true
	set_process_input(false)
	pass
	
func end_lock_out():
	$LockOutScreen.visible = false
	set_process_input(true)
	pass
