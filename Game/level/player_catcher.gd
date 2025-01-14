extends Area3D

signal player_reached_end


func _on_body_entered(body: Node3D) -> void:
	

	if body.is_in_group("Player"):
		$Label3D.visible = true
		await get_tree().create_timer(0.5).timeout
		emit_signal("player_reached_end")
	pass # Replace with function body.
