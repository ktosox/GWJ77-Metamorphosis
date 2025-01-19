extends VBoxContainer

@export var level_data : LevelData

signal level_selection_confirmed (data : LevelData)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	$ColorRect/Length.text = "Tunnel length: " + str(level_data.desired_length)
	$ColorRect/Loot.text = "Has " + str( level_data.loot_count ) + " loot"
	$ColorRect/Features.text = "Bonus feature: \n" + str(level_data.features[0].instantiate().name) + " and " + str(level_data.features[1].instantiate().name)
	$ColorRect/World.text = "Is in style " + str(level_data.world)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	emit_signal("level_selection_confirmed",level_data)
	pass # Replace with function body.
