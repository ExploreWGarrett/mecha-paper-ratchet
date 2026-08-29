class_name PlayerAbilityController extends Node

signal loadout_changed
signal notice_requested(text: String, duration: float)

const ABILITY_WRENCH_THROW := "wrench_throw"
const ABILITY_SLOT_FILL_ORDER: Array[StringName] = [&"ability_slot_1", &"ability_slot_3", &"ability_slot_2"]

var unlocked_ability_ids: Array[String] = []
var ability_slot_assignments: Dictionary = {
	&"ability_slot_1": "",
	&"ability_slot_2": "",
	&"ability_slot_3": "",
}

func reset() -> void:
	unlocked_ability_ids.clear()
	for slot_action in ABILITY_SLOT_FILL_ORDER:
		ability_slot_assignments[slot_action] = ""
	loadout_changed.emit()

func unlock_ability(ability_id: String, auto_assign: bool = true) -> void:
	if ability_id == "":
		return
	if ability_id not in unlocked_ability_ids:
		unlocked_ability_ids.append(ability_id)
	if auto_assign:
		_auto_assign_ability_slot(ability_id)
	loadout_changed.emit()

func _auto_assign_ability_slot(ability_id: String) -> void:
	if get_ability_slot_action(ability_id) != StringName():
		return
	for slot_action in ABILITY_SLOT_FILL_ORDER:
		if String(ability_slot_assignments.get(slot_action, "")) == "":
			assign_ability_to_slot(ability_id, slot_action, false)
			return

func assign_ability_to_slot(ability_id: String, slot_action: StringName, announce: bool = true) -> void:
	if ability_id == "" or slot_action not in ABILITY_SLOT_FILL_ORDER:
		return
	if ability_id not in unlocked_ability_ids:
		unlocked_ability_ids.append(ability_id)
	var previous_slot: StringName = get_ability_slot_action(ability_id)
	var occupying_ability: String = String(ability_slot_assignments.get(slot_action, ""))
	if previous_slot != StringName():
		ability_slot_assignments[previous_slot] = ""
	if occupying_ability != "" and occupying_ability != ability_id and previous_slot != StringName():
		ability_slot_assignments[previous_slot] = occupying_ability
	elif occupying_ability != "" and occupying_ability != ability_id and previous_slot == StringName():
		ability_slot_assignments[slot_action] = ""
	ability_slot_assignments[slot_action] = ability_id
	if announce:
		notice_requested.emit("%s set to %s" % [_get_ability_display_name(ability_id), get_slot_label_for_action(slot_action)], 1.4)
	loadout_changed.emit()

func get_ability_slot_action(ability_id: String) -> StringName:
	for slot_action in ABILITY_SLOT_FILL_ORDER:
		if String(ability_slot_assignments.get(slot_action, "")) == ability_id:
			return slot_action
	return StringName()

func cycle_boomerang_ability_slot_action() -> void:
	var current_slot: StringName = get_ability_slot_action(ABILITY_WRENCH_THROW)
	var current_index: int = ABILITY_SLOT_FILL_ORDER.find(current_slot)
	if current_index == -1:
		current_index = 0
	assign_ability_to_slot(ABILITY_WRENCH_THROW, ABILITY_SLOT_FILL_ORDER[(current_index + 1) % ABILITY_SLOT_FILL_ORDER.size()])

func get_slot_label_for_action(slot_action: StringName) -> String:
	match String(slot_action):
		"ability_slot_3":
			return "F"
		"ability_slot_2":
			return "Q"
		_:
			return "E"

func _get_ability_display_name(ability_id: String) -> String:
	match ability_id:
		ABILITY_WRENCH_THROW:
			return "Wrench Throw"
		_:
			return ability_id.capitalize()

func set_boomerang_ability_slot_action(action_name: StringName) -> void:
	assign_ability_to_slot(ABILITY_WRENCH_THROW, action_name)

func get_boomerang_ability_slot_label() -> String:
	return get_slot_label_for_action(get_ability_slot_action(ABILITY_WRENCH_THROW))

func get_assigned_ability(slot_action: StringName) -> String:
	return String(ability_slot_assignments.get(slot_action, ""))

func get_loadout_text() -> String:
	var parts: Array[String] = []
	for slot_action in ABILITY_SLOT_FILL_ORDER:
		var ability_id: String = String(ability_slot_assignments.get(slot_action, ""))
		var slot_label: String = get_slot_label_for_action(slot_action)
		parts.append("%s:%s" % [slot_label, "--" if ability_id == "" else _get_ability_display_name(ability_id)])
	return " | ".join(parts)
