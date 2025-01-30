extends Node3D

@export var data : LevelData

@onready var loading_screen = $Overlay/LoadingScreen

var player_scene = preload("res://player/player.tscn")

var segment_scene = preload("res://level/segments/segment_base.tscn")

var bigger_segment_scene = preload("res://level/segments/segment_bigger.tscn")

var floor_scene = preload("res://level/floor_segment.tscn")

var loot_scene_array = [preload("res://not_player/loot/loot3.tscn")]

var segment_materials_regular ={
	1 : [load("res://level/segments/world1/vapor1_material.tres"), load("res://level/segments/world1/vapor2_material.tres")],
	2 : [load("res://level/segments/world2/generic_water_material.tres"),load("res://level/segments/world2/water2_material.tres")],
	3 : [load("res://level/segments/world3/checkerboard_material_small.tres")]
}

var segment_materials_big ={
	1 : [load("res://level/segments/world1/vapor_bricks1_material.tres") ],
	2 : [load("res://level/segments/world2/generic_water_material.tres"), load("res://level/segments/world2/water_big_material.tres")],
	3 : [load("res://level/segments/world3/checkerboard_material_big.tres")]
}

var _total_length : int

var _valid_location_array = []

signal level_complete()

func _ready() -> void:
	create_segments()
	await get_tree().create_timer(0.4).timeout
	loading_screen.get_node("ProgressBar").value += 10 + randi()%26
	create_floors()
	await get_tree().create_timer(0.4).timeout
	loading_screen.get_node("ProgressBar").value += 10 + randi()%26
	create_features()
	await get_tree().create_timer(0.4).timeout
	loading_screen.get_node("ProgressBar").value += 10 + randi()%39
	create_loot()
	await get_tree().create_timer(0.4).timeout
	loading_screen.get_node("ProgressBar").value = 100
	loading_screen.get_node("LoadingComplete").visible = true
	$Music.play(randf() * 300)
	$Music/AnimationPlayer.play("in")
	
	#print("_total_length ", _total_length)
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and loading_screen.get_node("LoadingComplete").visible:
		start_game()

func start_game() -> void:
	loading_screen.get_node("LoadingComplete").visible = false
	spawn_player()
	loading_screen.visible = false
	await get_tree().create_timer(0.4).timeout
	$Overlay/TimeShower.visible = true
	$Overlay/TimeShower.set_process(true)

func create_segments() -> void:

	var segment_offset = 0
	while _total_length < data.desired_length:
		var new_segment
		match randi()%2:
			0: 
				new_segment = segment_scene.instantiate() as Node3D
				new_segment.get_node("Mesh").set_surface_override_material(0,segment_materials_regular[data.world][randi()%segment_materials_regular[data.world].size()])
			1: 
				new_segment = bigger_segment_scene.instantiate() as Node3D
				new_segment.get_node("Mesh").set_surface_override_material(0,segment_materials_big[data.world][randi()%segment_materials_big[data.world].size()])
		$SegmentsGoHere.add_child(new_segment)
		new_segment.global_position = Vector3(0,segment_offset,0)

		segment_offset -= new_segment.get_meta("length")
		
		_total_length = abs(segment_offset)
		pass
	
	
	
	
	

	
	var length_to_chunk_ratio = 4 
	var first_floor_zone = 12 # nothing spawns here becouse too soon
	for chunk in range(first_floor_zone, _total_length, length_to_chunk_ratio):
		_valid_location_array.push_back(chunk * -1)
	# populate _valid_location_array by taking the length of the tunnel and arbitrarly placing points in it
	

	
	$PlayerCatcher.global_position = Vector3(0,_valid_location_array.pop_back(),0) # move $PlayerCatcher to the end of the last segment
	pass
	

func create_floors() -> void:
	var length_to_floor_ratio = 16

	var desired_floor_count = roundi(_total_length/length_to_floor_ratio)
	var array_of_spots_to_remove_later = []
	var tick_shift_point = _valid_location_array.size() / (desired_floor_count * 1.0)
	var next_floor_tick = 0.0
	var next_floor_rotation = 0.0
	for tick in _valid_location_array.size():
		
		if next_floor_tick >= tick_shift_point:
			var selected_valid_location = _valid_location_array[tick]
			var new_floor = floor_scene.instantiate() as Node3D
			$FeaturesGoHere.add_child(new_floor)
			new_floor.global_rotation_degrees = Vector3(0, next_floor_rotation,0 )
			next_floor_rotation += randi_range(1,2) * (90.0)
			new_floor.global_position = Vector3(0,selected_valid_location,0)
			array_of_spots_to_remove_later.push_back(selected_valid_location)
			next_floor_tick -= tick_shift_point
		else:
			next_floor_tick += 1
	for a in array_of_spots_to_remove_later:
		_valid_location_array.erase(a)

func create_features() -> void:
	
	
	
	for feature in data.features:
		var spot = _valid_location_array[randi()%_valid_location_array.size()]
		var new_feature = feature.instantiate() as Node3D
		new_feature.global_position = Vector3(0,spot,0)
		$FeaturesGoHere.add_child(new_feature)
		_valid_location_array.erase(spot)
	pass


func create_loot() -> void:
	var from_range = -1
	var to_range = 1
	var loot_spawned = 0
	while loot_spawned < data.loot_count:
		var new_loot = loot_scene_array[randi()%loot_scene_array.size()].instantiate() as Node3D
		$LootGoesHere.add_child(new_loot)
		var spot = _valid_location_array[randi()%_valid_location_array.size()]
		new_loot.global_position = Vector3(randi_range(from_range,to_range),spot,randi_range(from_range,to_range))
		loot_spawned += 1
		_valid_location_array.erase(spot)
			
			
			
	
	pass

func spawn_player() -> void:
	var new_player = player_scene.instantiate()
	
	new_player.global_position = $PlayerSpawnPoint.global_position
	add_child(new_player)
	
	
	pass


func _on_player_catcher_player_reached_end() -> void:
	$Music/AnimationPlayer.play("out")
	$Overlay/TimeShower.set_process(false)
	await get_tree().create_timer(1.7).timeout
	emit_signal("level_complete")
	queue_free()
	pass # Replace with function body.
