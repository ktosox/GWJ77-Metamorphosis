extends Node


enum Skill_Types {VIRTUAL,TASTY,SMART}


var _skills = {
	Skill_Types.VIRTUAL : 0,
 	Skill_Types.TASTY : 0, 
	Skill_Types.SMART : 0
	}

var _free_skill_points = 3

signal player_was_damaged (amount : int)

signal loot_was_collected (loot : LootPacket)


func has_skill_level(skill:Skill_Types,level:int) -> bool:
	if _skills[skill] >= level:
		return true 
	return false

func add_skill_point(skill:Skill_Types) -> bool:
	if _free_skill_points < 1:
		return false
	_skills[skill] += 1
	_free_skill_points -= 1

	return true
