extends Area3D

@export var packet : BumpPacket

func _ready() -> void:
	assert(packet != null)
	
	
func _on_body_entered(body: Node3D) -> void:
	assert(body.is_in_group("Player"))
	body.take_bump(packet)
	pass # Replace with function body.
