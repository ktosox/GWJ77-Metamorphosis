extends MeshInstance3D

var text_range = ["大\n\n水\n\n和","水\n\n生\n\n今","人\n\n市\n\n新"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = text_range[randi()%text_range.size()]

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
