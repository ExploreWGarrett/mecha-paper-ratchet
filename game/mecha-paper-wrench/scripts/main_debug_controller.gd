class_name MainDebugController extends Node

var player: Node
var pause_button_map: Dictionary = {}
var separate_button_map: Dictionary = {}
var debug_overlay: Control
var debug_menu_title_label: Label
var debug_menu_hint_label: Label
var debug_close_button: Button
var debug_menu_active: bool = false
var selected_index: int = 0

func configure(new_player: Node, new_pause_button_map: Dictionary, new_separate_button_map: Dictionary, new_overlay: Control, new_title: Label, new_hint: Label, new_close_button: Button) -> void:
	player = new_player
	pause_button_map = new_pause_button_map
	separate_button_map = new_separate_button_map
	debug_overlay = new_overlay
	debug_menu_title_label = new_title
	debug_menu_hint_label = new_hint
	debug_close_button = new_close_button
	for mechanic_id in pause_button_map.keys():
		var pause_button: Button = pause_button_map[mechanic_id]
		pause_button.pressed.connect(func() -> void: toggle_mechanic(String(mechanic_id)))
	for mechanic_id in separate_button_map.keys():
		var separate_button: Button = separate_button_map[mechanic_id]
		separate_button.pressed.connect(func() -> void: toggle_mechanic(String(mechanic_id)))
	debug_close_button.pressed.connect(close_menu)
	refresh_pause_panel()
	refresh_separate_menu()

func refresh_pause_panel() -> void:
	_apply_rows_to_buttons(pause_button_map)

func refresh_separate_menu() -> void:
	_apply_rows_to_buttons(separate_button_map)

func toggle_mechanic(mechanic_id: String) -> void:
	if player and player.has_method("toggle_debug_mechanic"):
		player.toggle_debug_mechanic(mechanic_id)
	refresh_pause_panel()
	refresh_separate_menu()

func is_menu_active() -> bool:
	return debug_menu_active

func open_menu() -> void:
	if debug_menu_active:
		return
	debug_menu_active = true
	selected_index = 0
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	debug_overlay.visible = true
	debug_menu_title_label.text = "Mechanic Debug"
	debug_menu_hint_label.text = "~ / Esc = close   |   W/S or A/D = select   |   Space = toggle   |   Scroll for more"
	refresh_separate_menu()
	_refresh_focus()

func close_menu() -> void:
	debug_menu_active = false
	debug_overlay.visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func handle_input(event: InputEvent) -> bool:
	if not debug_menu_active:
		return false
	if not event.is_pressed() or event.is_echo():
		return true
	if event.is_action_pressed("move_forward") or event.is_action_pressed("move_left"):
		_move_selection(-1)
	elif event.is_action_pressed("move_back") or event.is_action_pressed("move_right"):
		_move_selection(1)
	elif event.is_action_pressed("jump"):
		_activate_selected()
	return true

func _apply_rows_to_buttons(button_map: Dictionary) -> void:
	if player == null or not player.has_method("get_debug_mechanic_rows"):
		return
	for row in player.get_debug_mechanic_rows():
		var button: Button = button_map.get(String(row.get("id", "")))
		if button:
			button.text = "%s: %s" % [String(row.get("label", "Mechanic")), "On" if bool(row.get("enabled", false)) else "Off"]

func _get_selectables() -> Array[Control]:
	var controls: Array[Control] = [debug_close_button]
	controls.append_array(separate_button_map.values())
	return controls

func _get_focused_control() -> Control:
	var focus_owner := get_viewport().gui_get_focus_owner()
	return focus_owner as Control if focus_owner is Control else null

func _refresh_focus() -> void:
	var controls := _get_selectables()
	if controls.is_empty():
		return
	selected_index = clamp(selected_index, 0, controls.size() - 1)
	controls[selected_index].grab_focus()

func _move_selection(direction: int) -> void:
	var controls := _get_selectables()
	if controls.is_empty():
		return
	selected_index = posmod(selected_index + direction, controls.size())
	_refresh_focus()

func _activate_selected() -> void:
	var focused := _get_focused_control()
	if focused == null:
		_refresh_focus()
		focused = _get_focused_control()
	if focused is Button:
		(focused as Button).emit_signal("pressed")
