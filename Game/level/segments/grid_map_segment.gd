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
