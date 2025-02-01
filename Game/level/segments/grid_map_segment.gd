extends GridMap

# creates an 8x8 tunnel out of 2x2x4 mesh sections using an WFC algorithm
# start and end points are assumed as determined
# the process consits of 3 parts: observe, collpase, propagate
# observe picks the next thing
# collapse turns a fuzzy thing into a specific thing
# propagate passes on data to the neighbourse of the collpased thing
