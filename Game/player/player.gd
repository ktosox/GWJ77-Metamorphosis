extends RigidBody3D

const MOVE_FORCE = 10.0

var bonus_move_force = 0.0

var cant_take_damage = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bonus_move_force += 1.5 * GM.player_bonus_properties[PartData.Special_Property.AGILITY1] + 4 * GM.player_bonus_properties[PartData.Special_Property.AGILITY2]
	gravity_scale += 0.15 * GM.player_bonus_properties[PartData.Special_Property.SPEED1] + 0.35 * GM.player_bonus_properties[PartData.Special_Property.SPEED2]
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	
	
	
	var input_dir := Input.get_vector("Move_Left", "Move_Right", "Move_Up", "Move_Down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	apply_central_force(direction * (MOVE_FORCE + bonus_move_force))
	pass


func take_bump(data : BumpPacket) -> void:
	
	pass

func take_loot(data : LootPacket) -> void:
	print(data.type)
	GM.emit_signal("loot_was_collected",data)
	pass

func take_damage(amount:int) -> void:
	if cant_take_damage:
		return
	
	GM.emit_signal("player_was_damaged",amount)
	cant_take_damage = true
	$DamageTakenTimer.start()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_body_entered(body: Node) -> void:

	$BumpSound.play()
	take_damage(1)
	pass # Replace with function body.


func _on_damage_taken_timer_timeout() -> void:
	cant_take_damage = false
	pass # Replace with function body.
