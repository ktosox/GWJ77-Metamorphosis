extends Node3D

@export_range(1,3) var world = 1

@export var segment_count = 6

@export var feature_list : Array

var player_scene = preload("res://player/player.tscn")

var segment_scene = preload("res://level/segments/segment_base.tscn")



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
	for S in segment_count:
		var new_segment = segment_scene.instantiate() as Node3D
		new_segment.global_position = Vector3(0,segment_offset,0)

		segment_offset -= new_segment.get_meta("length")
		$SegmentsGoHere.add_child(new_segment)
		# make each segemnt and add it to $SegmentsGoHere
		pass
	$PlayerCatcher.global_position = Vector3(0,segment_offset+12,0)
	# move $PlayerCatcher to the end of the last segment
	pass
	

func create_features() -> void:
	# place features in range from the end of segment 1 to the top of last segment
	
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
