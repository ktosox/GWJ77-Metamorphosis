extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:


	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_transform_pressed() -> void:
	GM.transform_player(20)
	print("player_experience: ",GM.player_experience)
	print("player_level: ",GM.player_level)
	print("max_skill_points: ",GM.max_skill_points)
	print("skills: ",GM.skills)
	print("free_skill_points: ",GM.free_skill_points)
	pass # Replace with function body.
