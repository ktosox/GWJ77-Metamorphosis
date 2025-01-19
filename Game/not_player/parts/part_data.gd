class_name PartData

extends Resource

enum Special_Property {NONE,AGILITY1,AGILITY2,SPEED1,SPEED2}

@export var official_name : String

@export var description : String

@export var bonus_property : Special_Property

@export var mesh_scene : PackedScene

@export var experience_points = 20

@export var preview_texture : Texture

@export_range(0,2) var required_skill : int

@export_range(1,3) var required_level = 1
