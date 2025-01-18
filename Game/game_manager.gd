extends Node


enum Skill_Types {SPARKLING,TASTY,SMARTER}


var skills = {
	Skill_Types.SPARKLING : 0,
 	Skill_Types.TASTY : 0, 
	Skill_Types.SMARTER : 0
	}

var free_skill_points = 3

var max_skill_points = 2

signal player_was_damaged (amount : int)

signal loot_was_collected (loot : LootPacket)

signal skill_point_was_spent

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


func can_add_skill_point(skill:Skill_Types) -> bool:
	if free_skill_points < 1:
		return false
	if skills[skill] >= max_skill_points:
		return false
	return true
