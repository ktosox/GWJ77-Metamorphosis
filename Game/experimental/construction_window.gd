extends SubViewportContainer

var mouse_tracked = false

var last_mouse_pos : Vector2

@export var rotation_speed = 1.2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if mouse_tracked:
		
		var new_mouse_pos = $SubViewport.get_mouse_position()
		var difference = new_mouse_pos - last_mouse_pos
		$SubViewport/PlayerBuildingTest/ObjectHolder.rotate_x(difference.y * delta * rotation_speed)
		$SubViewport/PlayerBuildingTest/ObjectHolder.rotate_y(difference.x * delta * rotation_speed)

		last_mouse_pos = new_mouse_pos
		pass
	pass



func _on_gui_input(event: InputEvent) -> void:
	
	if event.is_class("InputEventMouseMotion"):
		$SubViewport/PlayerBuildingTest.update_preview()
	if event.is_action_pressed("RMB"):
		last_mouse_pos = $SubViewport.get_mouse_position()
		mouse_tracked = true
	if event.is_action_released("RMB"):
		mouse_tracked = false
	if event.is_action_pressed("LMB"):
		$SubViewport/PlayerBuildingTest.place_object()
	pass # Replace with function body.
