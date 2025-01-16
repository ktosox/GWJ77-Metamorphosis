extends Window

@export var tutorial_scene : NodePath

func _ready() -> void:
	connect("close_requested",Callable(self,"_on_close_requested"))

func _process(delta: float) -> void:
	position.x = clampi(position.x,10,1200)
	position.y = clampi(position.y,32,720)
	pass


func _on_focus_entered() -> void:
	set_process(true)
	pass # Replace with function body.


func _on_focus_exited() -> void:
	set_process(false)
	pass # Replace with function body.


func _on_close_requested() -> void:
	get_node(tutorial_scene).visible = !get_node(tutorial_scene).visible
	pass # Replace with function body.
