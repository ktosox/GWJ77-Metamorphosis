extends Button

signal linked_path_requested(path_screen : Control)

@export var linked_path : Control
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	emit_signal("linked_path_requested",linked_path)
	pass # Replace with function body.
