extends Node3D

@export_range(1,3) var world = 1

@export var segment_count = 6

@export var feature_list : Array

var player_scene = preload("res://player/player.tscn")

var segment_scene = preload("res://level/segments/segment_base.tscn")

var bigger_segment_scene = preload("res://level/segments/segment_bigger.tscn")

var floor_scene = preload("res://level/floor_segment.tscn")

var _total_length : int

signal level_complete

func _ready() -> void:
	create_segments()
	await get_tree().create_timer(0.4).timeout
	$LoadingScreen/ColorRect/ProgressBar.value += 20 + randi()%26
	create_features()
	await get_tree().create_timer(0.4).timeout
	$LoadingScreen/ColorRect/ProgressBar.value += 10 + randi()%39
	create_loot()
	await get_tree().create_timer(0.4).timeout
	$LoadingScreen/ColorRect/ProgressBar.value = 100
	$LoadingScreen/ColorRect/LoadingComplete.visible = true
	

	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and $LoadingScreen/ColorRect/LoadingComplete.visible:
		start_game()

func start_game() -> void:
	$LoadingScreen/ColorRect/LoadingComplete.visible = false
	spawn_player()
	$LoadingScreen.visible = false

func create_segments() -> void:
	assert(segment_count > 0)
	var segment_offset = 0
	for S in segment_count: # make each segemnt and add it to $SegmentsGoHere
		var new_segment
		match randi()%2:
			0: new_segment = segment_scene.instantiate() as Node3D
			1: new_segment = bigger_segment_scene.instantiate() as Node3D
		$SegmentsGoHere.add_child(new_segment)
		new_segment.global_position = Vector3(0,segment_offset,0)

		segment_offset -= new_segment.get_meta("length")
		
		
		pass
	$PlayerCatcher.global_position = Vector3(0,segment_offset+6,0) # move $PlayerCatcher to the end of the last segment
	
	
	_total_length = abs(segment_offset)
	pass
	

func create_features() -> void:
	# place features in range from the end of segment 1 to the top of last segment
	var length_to_floor_ratio = 36
	var first_floor_zone = 12
	var desired_floor_count = roundi(_total_length/length_to_floor_ratio)
	print(desired_floor_count)
	var next_floor_hight = first_floor_zone + randi()%4
	for count in desired_floor_count:
		var new_floor = floor_scene.instantiate() as Node3D
		$FeaturesGoHere.add_child(new_floor)
		new_floor.global_rotation_degrees = Vector3(0, randi_range(0,3) * (90.0),0 )
		new_floor.global_position = Vector3(0,-next_floor_hight,0)
		next_floor_hight += length_to_floor_ratio + randi_range(-6,6)
		
	pass


func create_loot() -> void:
	# place loot in range from the end of segment 1 to the top of last segment
	pass

func spawn_player() -> void:
	var new_player = player_scene.instantiate()
	new_player.global_position = $PlayerSpawnPoint.global_position
	add_child(new_player)
	pass


func _on_player_catcher_player_reached_end() -> void:
	
	pass # Replace with function body.
