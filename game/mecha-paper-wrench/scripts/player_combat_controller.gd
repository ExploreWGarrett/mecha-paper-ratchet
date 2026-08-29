class_name PlayerCombatController extends Node

const ABILITY_SLOT_ACTIONS: Array[StringName] = [&"ability_slot_1", &"ability_slot_3", &"ability_slot_2"]

var player: Node

func configure(new_player: Node) -> void:
	player = new_player

func handle_input(on_floor_before_move: bool, crouching: bool) -> void:
	if player == null:
		return
	if bool(player.call("_weapon_controls_active")):
		if Input.is_action_pressed("attack"):
			player.call("_fire_active_weapon_primary")
		if Input.is_action_just_pressed("secondary_attack"):
			player.call("_fire_active_weapon_secondary")
		if Input.is_action_just_pressed("melee_attack_alt"):
			player.call("_handle_primary_melee_action", on_floor_before_move, crouching)
		if Input.is_action_just_pressed("melee_secondary_alt"):
			player.call("_handle_secondary_melee_action", on_floor_before_move, crouching)
	else:
		if Input.is_action_just_pressed("attack"):
			player.call("_handle_primary_melee_action", on_floor_before_move, crouching)
		if Input.is_action_just_pressed("secondary_attack"):
			player.call("_handle_secondary_melee_action", on_floor_before_move, crouching)

func handle_assigned_ability_input() -> void:
	if player == null:
		return
	for slot_action in ABILITY_SLOT_ACTIONS:
		if Input.is_action_just_pressed(slot_action):
			player.call("_trigger_assigned_ability", slot_action)
