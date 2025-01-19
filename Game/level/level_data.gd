class_name LevelData
extends Resource

@export_range(1,3) var world = 3

@export var desired_length : int # how long should the level be

@export var loot_count : int

@export var features : Array[PackedScene]
