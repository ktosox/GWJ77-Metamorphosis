extends Area3D

@export var packet : LootPacket

func _ready() -> void:
	packet = LootPacket.new()
	packet.type = randi()%3
	packet.value = clampi( (randi()%GM.player_level) -1 ,0,2)
	rotation = Vector3(randf(),randf(),randf())
	

func _on_body_entered(body: Node3D) -> void:
	assert(body.is_in_group("Player"))
	body.take_loot(packet)
	queue_free()
	pass # Replace with function body.
