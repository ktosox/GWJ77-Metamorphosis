extends GridMap

# creates an 8x8 tunnel of arbitrary length out of 2x2x4 mesh sections using an WFC algorithm
# either start, end, or start + end points are assumed as determined when the generation begins
# the process consits of 3 parts: observe, collpase, propagate
# observe picks the next thing by finding the thing with "lowest entropy"
# collapse turns a fuzzy thing into a specific thing
# propagate passes on data to the neighbourse of the collpased thing

# at start an Array of all the un-collapsed spots needs to be created - AKA the Wave
# then a series of propagations outside the normal flow needs to be completed in order "reduce entropy" for the spots that touch pre-determined tiles
# then the real fun starts with the loop that begins with "observe" and keeps going till the Wave is empty





class Tile:
	var location : Vector3i
	var orientation : int
	var neighbours : Array[Vector3i]
	var state : int
	var valid_states = [0,1,2]
	var is_collpased = false
	func update_valid_states(touching_state : int) -> void:
		
		# logic for reducing size of valid_states goes here
		# it takes in the state of the annoucning neighbour and reduces valid_states accroding to logic
		match touching_state:
			1:
				valid_states.erase(2)
			2:
				valid_states.erase(1)
		pass


var wave : Dictionary # pairs locations as Vectro3i with Tile

var entropy_tier_list = { # pairs entropy size as int with an Array of Tile with the specified entropy
	1 : [],
	2 : [],
	3 : [],
} 

var all_valid_sections = {# a dictionary describing all 4 walls, where keys are the orientations and arrays have 4 cells each / y 
	3 : [Vector3i(-2,0,2),Vector3i(-2,0,1),Vector3i(-2,0,0),Vector3i(-2,0,-1)],
	11: [Vector3i(3,0,-1),Vector3i(3,0,0),Vector3i(3,0,1),Vector3i(3,0,2)],
	15 : [Vector3i(2,0,3),Vector3i(1,0,3),Vector3i(0,0,3),Vector3i(-1,0,3)],
	7 : [Vector3i(-1,0,-2),Vector3i(0,0,-2),Vector3i(1,0,-2),Vector3i(2,0,-2)],
	
	}

func find_linked_location(location : Vector3i) -> Array:
	var neigbours = []
	var base_layer = []
	if location.x == -2:
		if location.z == 2: # we need to teleoprt to a diffrent section
			base_layer.push_back(location)
			base_layer.push_back(location + Vector3i(0,0,-1))
			base_layer.push_back(Vector3i(-1,0,3) + Vector3i(0,location.y,0))
		elif location.z == -1: # we need to teleoprt to a diffrent section
			base_layer.push_back(location)
			base_layer.push_back(location + Vector3i(0,0,1))
			base_layer.push_back(Vector3i(-1,0,-2) + Vector3i(0,location.y,0))
		else: # we stay in the same section
			for n in [-1,0,1]: 
				base_layer.push_back(location + Vector3i(0,0,n))
	if location.x == 3:
		if location.z == 2: # we need to teleoprt to a diffrent section
			base_layer.push_back(location)
			base_layer.push_back(location + Vector3i(0,0,-1))
			base_layer.push_back(Vector3i(2,0,3) + Vector3i(0,location.y,0))
		elif location.z == -1: # we need to teleoprt to a diffrent section
			base_layer.push_back(location)
			base_layer.push_back(location + Vector3i(0,0,1))
			base_layer.push_back(Vector3i(2,0,-2) + Vector3i(0,location.y,0))
		else: # we stay in the same section
			for n in [-1,0,1]: 
				base_layer.push_back(location + Vector3i(0,0,n))
	if location.z == -2:
		if location.x == 2: # we need to teleoprt to a diffrent section
			base_layer.push_back(location)
			base_layer.push_back(location + Vector3i(-1,0,0))
			base_layer.push_back(Vector3i(3,0,-1) + Vector3i(0,location.y,0))
		elif location.x == -1: # we need to teleoprt to a diffrent section
			base_layer.push_back(location)
			base_layer.push_back(location + Vector3i(1,0,0))
			base_layer.push_back(Vector3i(-2,0,-1) + Vector3i(0,location.y,0))
		else: # we stay in the same section
			for n in [-1,0,1]: 
				base_layer.push_back(location + Vector3i(n,0,0))
	if location.z == 3:
		if location.x == 2: # we need to teleoprt to a diffrent section
			base_layer.push_back(location)
			base_layer.push_back(location + Vector3i(-1,0,0))
			base_layer.push_back(Vector3i(3,0,2) + Vector3i(0,location.y,0))
		elif location.x == -1: # we need to teleoprt to a diffrent section
			base_layer.push_back(location)
			base_layer.push_back(location + Vector3i(1,0,0))
			base_layer.push_back(Vector3i(-2,0,2) + Vector3i(0,location.y,0))
		else: # we stay in the same section
			for n in [-1,0,1]: 
				base_layer.push_back(location + Vector3i(n,0,0))

	for n in [-1,0,1]:
		for m in base_layer:
			neigbours.push_back(m + Vector3i(0,n,0))
	neigbours.erase(location)

	return neigbours

func _ready() -> void:
	for cell in get_used_cells():
		set_cell_item(cell,-1)
	find_linked_location(Vector3i(-2,10,2))
	#var iteration = 0
	#for section in all_valid_sections:
		#
		#for location in all_valid_sections[section]:
			#
			#set_cell_item(location,iteration,section)
		#iteration += 1
	#create_empty_tiles(-6,2)


	#for z in 24:
		#set_cell_item(Vector3i(z,0,0),0,z)
	#pass

func create_empty_tiles(from : int, to : int) -> void: # creates an Array of Vector3i represeting locations on GridMap between "from" and "to" (inclusive)
	assert(from < to)
	var list_of_locations_by_Y : Dictionary
	var current_floor = from
	while current_floor <= to: # populate array_of_locations wit hall of the locations
		list_of_locations_by_Y[current_floor] = []
		for section in all_valid_sections:
			
			for loc in all_valid_sections[section]:
				
				list_of_locations_by_Y[current_floor].push_back(loc + Vector3i(0,current_floor,0) )
		current_floor += 1
	for floor in list_of_locations_by_Y: # for each floor (which is an Array) in list_of_locations_by_Y
		for location in floor: # make a tile for each
			var new_Tile = Tile.new()
		# populate the Tiles.neighbours array with the locations
			
			if floor != from:
				# add neigbourhs above
				pass
			if floor != to:
				# add neigbourhs below
				pass
		# remeber to add 2 excpetions - the first and last row, so Y = from and Y = to
	

func collapse_tile_at_loc(location : Vector3i) -> void:
	var selected_tile = wave[location] as Tile
	assert(!selected_tile.is_collpased)
	selected_tile.state = selected_tile.valid_states[randi()%selected_tile.valid_states.size()]
	selected_tile.is_collpased = true

	propagate_collapse(selected_tile.state,selected_tile.neighbours)
	pass

func propagate_collapse(state : int, list : Array) -> void:
	
	for tile in list:
		var tile_to_update = wave[tile]
		if !tile_to_update.is_collpased:
			var before = tile_to_update.valid_states.size()
			tile_to_update.update_valid_states(state)
			var after = tile_to_update.valid_states.size()
			if before != after:
				entropy_tier_list[before].erase(tile_to_update)
				entropy_tier_list[after].push_back(tile_to_update)
			pass
	pass

#func create_floor() -> void:
	#for section in sections:
		#for loc in sections[section]:
			#set_cell_item(loc + Vector3i(0,current_floor,0),0,section)
	#pass
