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

var sections = {
	11: [Vector3i(3,0,-1),Vector3i(3,0,0),Vector3i(3,0,1),Vector3i(3,0,2)],
	3 : [Vector3i(-2,0,-1),Vector3i(-2,0,0),Vector3i(-2,0,1),Vector3i(-2,0,2)],
	7 : [Vector3i(-1,0,-2),Vector3i(0,0,-2),Vector3i(1,0,-2),Vector3i(2,0,-2)],
	15 : [Vector3i(-1,0,3),Vector3i(0,0,3),Vector3i(1,0,3),Vector3i(2,0,3)],
	
	}

func _ready() -> void:
	for cell in get_used_cells():
		set_cell_item(cell,-1)
	for section in sections:
		for loc in sections[section]:
			set_cell_item(loc,0,section)

	#for z in 24:
		#set_cell_item(Vector3i(z,0,0),0,z)
	#pass
