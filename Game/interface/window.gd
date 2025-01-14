extends Window



func _process(delta: float) -> void:
	position.x = clampi(position.x,10,1200)
	position.y = clampi(position.y,32,720)
	pass


func _on_focus_entered() -> void:
	set_process(true)
	pass # Replace with function body.


func _on_focus_exited() -> void:
	set_process(false)
	pass # Replace with function body.
