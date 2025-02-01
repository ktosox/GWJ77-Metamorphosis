extends Window

var minimize_window_button_scene = preload("res://interface/minimize_window_button.tscn")

@export var tutorial_scene : NodePath

@export_multiline var side_bar_title : String

signal minimize_button_created(button : Button)

func _ready() -> void:
	
	connect("close_requested",Callable(self,"_on_close_requested"))
	create_minimize_button()


func _process(delta: float) -> void:
	position.x = clampi(position.x,10,1200)
	position.y = clampi(position.y,32,720)
	pass

func create_minimize_button() -> void:
	var new_button = minimize_window_button_scene.instantiate() as Button
	new_button.text = side_bar_title
	new_button.connect("pressed",Callable(self, "toggle_visibility"))
	emit_signal("minimize_button_created",new_button)
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

func toggle_visibility() -> void:
	visible = !visible
	pass
