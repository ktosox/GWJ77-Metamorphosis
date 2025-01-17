extends NinePatchRect

@export var data : PartData 

signal part_selected(data : PartData)

func _ready() -> void:
	assert(data != null)
	# set up things based on data
	
	$Layout/TextureRect.texture = data.preview_texture
	$Layout/Button.text = str(data.required_level) +' '+ str(GM.Skill_Types.keys()[data.required_skill])
	pass

func _on_button_pressed() -> void:
	emit_signal("part_selected",data)
	pass # Replace with function body.
