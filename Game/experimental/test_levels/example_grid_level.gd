extends GridMap

var last_layer_depth = 0

var base_tile_layer_array = []


var all_valid_sections = {# a dictionary describing all 4 walls, where keys are the orientations and arrays have 4 cells each / y 
	3 : [Vector3i(-2,0,2),Vector3i(-2,0,1),Vector3i(-2,0,0),Vector3i(-2,0,-1)],
	11: [Vector3i(3,0,-1),Vector3i(3,0,0),Vector3i(3,0,1),Vector3i(3,0,2)],
	15 : [Vector3i(2,0,3),Vector3i(1,0,3),Vector3i(0,0,3),Vector3i(-1,0,3)],
	7 : [Vector3i(-1,0,-2),Vector3i(0,0,-2),Vector3i(1,0,-2),Vector3i(2,0,-2)],
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# floor
	for tile_location in all_valid_sections[15]:
		set_cell_item(tile_location,1,15)

		
	# roof
	for tile_location in all_valid_sections[7]:
		set_cell_item(tile_location,2,7)


	#left wall
	for tile_location in all_valid_sections[11]:
		set_cell_item(tile_location,3,11)


	#right wall
	for tile_location in all_valid_sections[3]:
		set_cell_item(tile_location,3,3)


	base_tile_layer_array = get_used_cells()
	create_next_layer(5)
	pass # Replace with function body.


func create_next_layer(count = 1) -> void:
	# create n more layers of tiles, each time iterating over base_tile_layer_array
	while count > 0:
		for base_tile_location in base_tile_layer_array:
			var new_location = base_tile_location + Vector3i(0,last_layer_depth,0)
			var desired_tile = get_cell_item(base_tile_location)
			var desired_orientation = get_cell_item_orientation(base_tile_location)
			set_cell_item(new_location,desired_tile,desired_orientation)
		count -= 1
		last_layer_depth -= 1
	pass


func _on_test_level_duplicator_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		$TestLevelDuplicator.global_position += Vector3(0,-60,0)
		create_next_layer(15)
		pass
		
	pass # Replace with function body.
