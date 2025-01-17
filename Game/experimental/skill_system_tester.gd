extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(GM.has_skill_level(GM.Skill_Types.VIRTUAL,1))
	GM.add_skill_point(GM.Skill_Types.VIRTUAL)
	print(GM.has_skill_level(GM.Skill_Types.VIRTUAL,1))

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
