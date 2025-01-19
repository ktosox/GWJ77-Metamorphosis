extends VBoxContainer

@export var test_data : PartData

func _ready() -> void:
	load_part_data(test_data)

func load_part_data(data : PartData):
	$NameOfPart.text = data.official_name
	$SpecialProperty.text = translate_special_prop_to_human(data.bonus_property)
	$Description.text = data.description
	$Experience.text = "Experience: " + str(data.experience_points)
	pass

func translate_special_prop_to_human(prop : PartData.Special_Property):
	var result : String
	match prop:
		PartData.Special_Property.NONE:
			result = "No special property"
		PartData.Special_Property.AGILITY1:
			result = "Makes you more agile"
		PartData.Special_Property.AGILITY2:
			result = "Makes you very agile"
		PartData.Special_Property.SPEED1:
			result = "Makes you fall faster"
		PartData.Special_Property.SPEED2:
			result = "Makes you fall very fast"
	return result
