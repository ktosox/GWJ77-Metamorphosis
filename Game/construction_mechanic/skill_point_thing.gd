extends VBoxContainer

@export var tracked_skill : GM.Skill_Types

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GM.connect("skill_point_was_spent",Callable(self,"_on_visibility_changed"))
	$Label.text = str(GM.Skill_Types.keys()[tracked_skill])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_visibility_changed() -> void:
	$ColorRect/CenterContainer/Label.text = str(GM.skills[tracked_skill])
	
	$Button.disabled = !GM.can_add_skill_point(tracked_skill)

	pass # Replace with function body.


func _on_button_pressed() -> void:
	GM.add_skill_point(tracked_skill)


	
	pass # Replace with function body.
