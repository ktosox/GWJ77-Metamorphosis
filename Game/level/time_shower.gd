extends Label

var current_time : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	
	current_time = GM.player_time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	current_time -= delta
	if current_time < 0.0:
		GM.game_over()
	var seconds = int(current_time)%60
	var minutes = (int(current_time)/60)%60
	text = str("%02d : %02d" % [minutes, seconds])
	pass
