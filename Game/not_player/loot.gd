extends Area3D

@export var packet : LootPacket

func _ready() -> void:
	assert(packet != null)
	rotation = Vector3(randf(),randf(),randf())
	

func _on_body_entered(body: Node3D) -> void:
	assert(body.is_in_group("Player"))
	body.take_loot(packet)
	queue_free()
	pass # Replace with function body.
