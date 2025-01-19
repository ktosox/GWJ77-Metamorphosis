extends StaticBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randi()%2 == 1:
		$CollisionShape3D2.disabled = true
		$MeshInstance3D.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
