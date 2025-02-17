extends Area3D


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Feature"):
		body.queue_free()
		#should probably be replaced with a smarter way to clean stuff up, wbut this will work for now
	pass # Replace with function body.
