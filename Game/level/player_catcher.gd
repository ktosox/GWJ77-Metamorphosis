extends Area3D

signal player_reached_end


func _on_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		emit_signal("player_reached_end")
	pass # Replace with function body.
