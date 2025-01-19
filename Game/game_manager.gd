extends Node


enum Skill_Types {SPARKLE,TASTY,SMARTER}


var skills = {
	Skill_Types.SPARKLE : 0,
 	Skill_Types.TASTY : 0, 
	Skill_Types.SMARTER : 0
	}

var free_skill_points = 3

var max_skill_points = 1

var player_experience = 220

var player_time = 300

var player_level = 1

var more_points_treshold = 60

var higher_level_treshold = 90

signal player_was_damaged (amount : int)

signal loot_was_collected (loot : LootPacket)

signal skill_point_was_spent

signal player_has_transformed

signal falling_started

signal falling_ended


func transform_player(experience : int) -> void:
	player_experience += experience
	player_level = round(player_experience/higher_level_treshold) + 1
	max_skill_points = player_level
	for skill in skills:
		skills[skill] = 0
	free_skill_points = round(player_experience/more_points_treshold) + 2
	emit_signal("skill_point_was_spent")
	emit_signal("player_has_transformed")
	
# SKILL POINT STUFF

func has_skill_level(skill:Skill_Types,level:int) -> bool:
	if skills[skill] >= level:
		return true 
	return false

func add_skill_point(skill:Skill_Types) -> void:
	if !can_add_skill_point(skill):
		return
	skills[skill] += 1
	free_skill_points -= 1
	emit_signal("skill_point_was_spent")


func get_part_type_data(type: Skill_Types, level = 0) -> PartData:
	var data_to_return : PartData
	match type:
		Skill_Types.SPARKLE :
			data_to_return = $PartDefinitions.gem_parts[level]
			
		Skill_Types.TASTY :
			data_to_return = $PartDefinitions.food_parts[level]
			
		Skill_Types.SMARTER :
			data_to_return = $PartDefinitions.chess_parts[level]

	return data_to_return

func can_add_skill_point(skill:Skill_Types) -> bool:
	if free_skill_points < 1:
		return false
	if skills[skill] >= max_skill_points:
		return false
	return true
