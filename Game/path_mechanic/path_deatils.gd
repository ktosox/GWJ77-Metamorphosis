extends VBoxContainer

@export var level_data : LevelData

signal level_selection_confirmed (data : LevelData)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	emit_signal("level_selection_confirmed",level_data)
	pass # Replace with function body.
