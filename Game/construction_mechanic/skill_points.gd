extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GM.connect("skill_point_was_spent",Callable(self,"update_skill_point_amount"))
	GM.connect("player_has_transformed",Callable(self,"update_skill_point_amount"))
	GM.connect("player_has_transformed",Callable(self,"update_skill_point_max"))
	update_skill_point_amount()
	update_skill_point_max()
	pass # Replace with function body.


func update_skill_point_amount():
	$SkillPointAmount.text = str(GM.free_skill_points)
	pass

func update_skill_point_max():
	$SkillPointsMax.text = str(GM.max_skill_points)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
