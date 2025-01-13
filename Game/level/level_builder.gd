extends Node3D

@export_range(1,3) var world = 1

@export var segment_count = 4

var player_scene = preload("res://player/player.tscn")



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
	spawn_player()
	get_tree().paused = true
	pass


func create_segments() -> void:
	assert(segment_count > 0)
	
	for S in segment_count:
		# make each segemnt and add it to $SegmentsGoHere
		pass
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
