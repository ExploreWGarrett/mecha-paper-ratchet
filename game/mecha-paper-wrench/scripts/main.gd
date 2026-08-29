extends Node3D

const PAPER_POPPER_REWARD_XP := 50
var current_level_index: int = 0
var menu_active: bool = false
var menu_mode: String = ""
var menu_actions: Array[String] = []
var menu_selected_index: int = 0
var settings_visible: bool = false
var controls_visible: bool = false
var debug_visible: bool = false
var paper_popper_reward_seen: bool = false

@onready var player: CharacterBody3D = $Player
@onready var level_controller: Node = $LevelController
@onready var debug_controller: Node = $DebugController
@onready var settings_controller: Node = $SettingsController
@onready var circle_arena: Node3D = $LevelGeometry/CircleArena
@onready var square_arena: Node3D = $LevelGeometry/SquareArena
@onready var circle_floor_shape: CollisionShape3D = $LevelGeometry/CircleArena/ArenaFloor/CollisionShape3D
@onready var square_floor_shape: CollisionShape3D = $LevelGeometry/SquareArena/ArenaFloor/CollisionShape3D
@onready var status_label: Label = $CanvasLayer/StatusLabel
@onready var controls_label: Label = $CanvasLayer/Label
@onready var crosshair_label: Label = $CanvasLayer/Crosshair
@onready var menu_overlay: Control = $CanvasLayer/MenuOverlay
@onready var menu_title_label: Label = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/MenuTitle
@onready var menu_subtitle_label: Label = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/MenuSubtitle
@onready var menu_hint_label: Label = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/MenuHint
@onready var primary_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/MenuButtons/PrimaryButton
@onready var secondary_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/MenuButtons/SecondaryButton
@onready var settings_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/UtilityButtons/SettingsButton
@onready var controls_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/UtilityButtons/ControlsButton
@onready var debug_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/UtilityButtons/DebugButton
@onready var settings_panel: VBoxContainer = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel
@onready var debug_panel: VBoxContainer = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/DebugPanel
@onready var volume_slider: HSlider = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/VolumeRow/VolumeSlider
@onready var volume_value_label: Label = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/VolumeRow/VolumeValue
@onready var sensitivity_slider: HSlider = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/SensitivityRow/SensitivitySlider
@onready var sensitivity_value_label: Label = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/SensitivityRow/SensitivityValue
@onready var fov_slider: HSlider = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/FovRow/FovSlider
@onready var fov_value_label: Label = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/FovRow/FovValue
@onready var difficulty_slider: HSlider = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/DifficultyRow/DifficultySlider
@onready var difficulty_value_label: Label = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/DifficultyRow/DifficultyValue
@onready var camera_mode_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/CameraModeRow/CameraModeButton
@onready var boomerang_slot_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/BoomerangSlotRow/BoomerangSlotButton
@onready var invert_y_check: CheckBox = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/InvertYCheck
@onready var crosshair_check: CheckBox = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/CrosshairCheck
@onready var camera_shake_check: CheckBox = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/SettingsPanel/CameraShakeCheck
@onready var controls_panel: RichTextLabel = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/ControlsPanel
@onready var wrench_mark_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/DebugPanel/WrenchMarkButton
@onready var enemy_spin_pull_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/DebugPanel/EnemySpinPullButton
@onready var crate_pull_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/DebugPanel/CratePullButton
@onready var catch_confirm_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/DebugPanel/CatchConfirmButton
@onready var sky_resistance_button: Button = $CanvasLayer/MenuOverlay/Panel/VBoxContainer/DebugPanel/SkyResistanceButton
@onready var debug_double_jump_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/MovementColumn/DoubleJumpButton
@onready var debug_high_jump_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/MovementColumn/HighJumpButton
@onready var debug_long_jump_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/MovementColumn/LongJumpButton
@onready var debug_feather_fall_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/MovementColumn/FeatherFallButton
@onready var debug_roll_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/MovementColumn/RollButton
@onready var debug_air_dodge_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/MovementColumn/AirDodgeButton
@onready var debug_ground_pound_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/MovementColumn/GroundPoundButton
@onready var debug_overlay: Control = $CanvasLayer/DebugOverlay
@onready var debug_menu_title_label: Label = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugMenuTitle
@onready var debug_menu_hint_label: Label = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugMenuHint
@onready var debug_close_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugCloseButton
@onready var debug_wrench_throw_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/CombatColumn/WrenchThrowButton
@onready var debug_lock_on_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/CombatColumn/LockOnButton
@onready var debug_paper_popper_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/CombatColumn/PaperPopperButton
@onready var debug_weapon_stance_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/CombatColumn/WeaponStanceButton
@onready var debug_wrench_mark_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/CombatColumn/WrenchMarkButton
@onready var debug_enemy_spin_pull_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/CombatColumn/EnemySpinPullButton
@onready var debug_crate_pull_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/CombatColumn/CratePullButton
@onready var debug_catch_confirm_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/CombatColumn/CatchConfirmButton
@onready var debug_sky_resistance_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/WorldColumn/SkyResistanceButton
@onready var debug_camera_shake_button: Button = $CanvasLayer/DebugOverlay/Panel/VBoxContainer/DebugScroll/Columns/WorldColumn/CameraShakeButton

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	randomize()
	level_controller.configure(self, player, circle_arena, square_arena, circle_floor_shape, square_floor_shape)
	level_controller.connect("level_started", Callable(self, "_on_level_started"))
	level_controller.connect("level_cleared", Callable(self, "_on_level_cleared"))
	debug_controller.configure(player, {
		"wrench_mark": wrench_mark_button,
		"enemy_spin_pull": enemy_spin_pull_button,
		"crate_pull": crate_pull_button,
		"catch_confirm": catch_confirm_button,
		"sky_resistance": sky_resistance_button,
	}, {
		"double_jump": debug_double_jump_button,
		"high_jump": debug_high_jump_button,
		"long_jump": debug_long_jump_button,
		"feather_fall": debug_feather_fall_button,
		"roll": debug_roll_button,
		"air_dodge": debug_air_dodge_button,
		"ground_pound": debug_ground_pound_button,
		"wrench_throw": debug_wrench_throw_button,
		"lock_on": debug_lock_on_button,
		"paper_popper": debug_paper_popper_button,
		"weapon_stance": debug_weapon_stance_button,
		"wrench_mark": debug_wrench_mark_button,
		"enemy_spin_pull": debug_enemy_spin_pull_button,
		"crate_pull": debug_crate_pull_button,
		"catch_confirm": debug_catch_confirm_button,
		"sky_resistance": debug_sky_resistance_button,
		"camera_shake": debug_camera_shake_button,
	}, debug_overlay, debug_menu_title_label, debug_menu_hint_label, debug_close_button)
	settings_controller.configure(player, crosshair_label, controls_panel, {
		"volume_slider": volume_slider,
		"volume_value_label": volume_value_label,
		"sensitivity_slider": sensitivity_slider,
		"sensitivity_value_label": sensitivity_value_label,
		"fov_slider": fov_slider,
		"fov_value_label": fov_value_label,
		"difficulty_slider": difficulty_slider,
		"difficulty_value_label": difficulty_value_label,
		"camera_mode_button": camera_mode_button,
		"boomerang_slot_button": boomerang_slot_button,
		"invert_y_check": invert_y_check,
		"crosshair_check": crosshair_check,
		"camera_shake_check": camera_shake_check,
	})
	settings_controller.connect("difficulty_changed", Callable(self, "_on_difficulty_changed"))
	for node in [menu_overlay, primary_button, secondary_button, settings_button, controls_button, debug_button, settings_panel, debug_panel, volume_slider, sensitivity_slider, fov_slider, difficulty_slider, camera_mode_button, boomerang_slot_button, invert_y_check, crosshair_check, camera_shake_check, controls_panel, wrench_mark_button, enemy_spin_pull_button, crate_pull_button, catch_confirm_button, sky_resistance_button, debug_overlay, debug_close_button, debug_double_jump_button, debug_high_jump_button, debug_long_jump_button, debug_feather_fall_button, debug_roll_button, debug_air_dodge_button, debug_ground_pound_button, debug_wrench_throw_button, debug_lock_on_button, debug_paper_popper_button, debug_weapon_stance_button, debug_wrench_mark_button, debug_enemy_spin_pull_button, debug_crate_pull_button, debug_catch_confirm_button, debug_sky_resistance_button, debug_camera_shake_button]:
		node.process_mode = Node.PROCESS_MODE_ALWAYS

	primary_button.pressed.connect(_on_primary_button_pressed)
	secondary_button.pressed.connect(_on_secondary_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	controls_button.pressed.connect(_on_controls_button_pressed)
	debug_button.pressed.connect(_on_debug_button_pressed)
	get_tree().paused = false
	menu_overlay.visible = false
	debug_overlay.visible = false
	controls_label.visible = false
	settings_panel.visible = false
	debug_panel.visible = false
	controls_panel.visible = false
	debug_button.visible = false
	_refresh_debug_panel()
	_refresh_separate_debug_menu()
	_refresh_controls_text()
	_initialize_settings_ui()
	_load_level(0, true, true)

func _process(_delta: float) -> void:
	_maybe_offer_paper_popper_reward()
	if Input.is_action_just_pressed("pause_menu"):
		_handle_pause_toggle()
	if Input.is_action_just_pressed("debug_menu"):
		_handle_debug_menu_toggle()
	_sync_mouse_mode_for_menu_state()

func _input(event: InputEvent) -> void:
	if debug_controller.is_menu_active():
		debug_controller.handle_input(event)
		return
	if not menu_active:
		return
	if not event.is_pressed() or event.is_echo():
		return

	var focused: Control = _get_focused_menu_control()
	if focused is HSlider:
		if event.is_action_pressed("move_left"):
			(focused as HSlider).value -= (focused as HSlider).step
			return
		if event.is_action_pressed("move_right"):
			(focused as HSlider).value += (focused as HSlider).step
			return

	if event.is_action_pressed("move_forward") or (event.is_action_pressed("move_left") and not focused is HSlider):
		_move_menu_selection(-1)
	elif event.is_action_pressed("move_back") or (event.is_action_pressed("move_right") and not focused is HSlider):
		_move_menu_selection(1)
	elif event.is_action_pressed("jump"):
		_activate_selected_menu_option()

func _load_level(level_index: int, reset_health: bool, reset_xp: bool) -> void:
	current_level_index = clamp(level_index, 0, level_controller.get_level_count() - 1)
	get_tree().paused = false
	menu_active = false
	menu_mode = ""
	settings_visible = false
	controls_visible = false
	debug_visible = false
	if debug_controller.is_menu_active():
		debug_controller.close_menu()
	debug_overlay.visible = false
	menu_overlay.visible = false
	_capture_game_mouse()
	if reset_xp:
		paper_popper_reward_seen = false
	level_controller.load_level(current_level_index, reset_health, reset_xp)

func _on_level_started(level_index: int, _level_name: String) -> void:
	current_level_index = level_index
	status_label.visible = true
	controls_label.visible = false

func _on_level_cleared(level_index: int, _level_data: Dictionary) -> void:
	current_level_index = level_index
	_show_level_clear_menu()

func _show_level_clear_menu() -> void:
	var level: Dictionary = level_controller.get_current_level_data()
	if current_level_index < level_controller.get_level_count() - 1:
		var next_level: Dictionary = level_controller.get_level_data(current_level_index + 1)
		menu_actions = ["next_level", "replay_level"]
		_show_menu("clear", level["menu_title"], level["menu_subtitle"], "Advance to %s" % next_level["name"], "Replay Current Level")
	else:
		menu_actions = ["restart_run", "replay_level"]
		_show_menu("clear", level["menu_title"], level["menu_subtitle"], "Restart from Level 1", "Replay Current Level")

func _maybe_offer_paper_popper_reward() -> void:
	if paper_popper_reward_seen or menu_active:
		return
	if player == null or not player.has_method("get_total_xp_earned"):
		return
	if player.has_method("has_weapon_unlocked") and player.has_weapon_unlocked("paper_popper"):
		paper_popper_reward_seen = true
		return
	if player.get_total_xp_earned() < PAPER_POPPER_REWARD_XP:
		return
	paper_popper_reward_seen = true
	menu_actions = ["equip_paper_popper", "unlock_paper_popper_melee"]
	_show_menu("reward", "New Weapon Found", "The Paper Popper is now available at 50 earned XP. Equip it now, or unlock it and stay on the wrench for the moment.", "Equip Paper Popper", "Unlock but Stay Melee")

func _open_pause_menu() -> void:
	menu_actions = ["resume_pause", "replay_level"]
	_show_menu("pause", "Paused", "Tweak settings, review controls, or jump back in.", "Resume", "Replay Current Level")

func _handle_pause_toggle() -> void:
	if debug_controller.is_menu_active():
		_close_debug_menu()
		return
	if menu_active and menu_mode in ["pause", "debug"]:
		_close_pause_menu()
		return
	if menu_active:
		settings_visible = false
		controls_visible = false
		debug_visible = false
		_refresh_aux_panels()
		return
	_open_pause_menu()

func _handle_debug_menu_toggle() -> void:
	if debug_controller.is_menu_active():
		_close_debug_menu()
		return
	if menu_active:
		_close_pause_menu()
	_open_debug_menu()

func _close_pause_menu() -> void:
	_resume_from_pause()

func _show_menu(new_mode: String, title: String, subtitle: String, primary_text: String, secondary_text: String) -> void:
	menu_active = true
	menu_mode = new_mode
	menu_selected_index = 0
	settings_visible = false
	controls_visible = false
	debug_visible = false
	get_tree().paused = true
	_release_menu_mouse()
	menu_overlay.visible = true
	menu_title_label.text = title
	menu_subtitle_label.text = subtitle
	menu_hint_label.text = "W/S or A/D = select   |   Space = confirm   |   A/D on sliders = adjust   |   Esc = back"
	primary_button.text = primary_text
	secondary_button.text = secondary_text
	settings_button.text = "Settings Menu"
	controls_button.text = "Controls Toggle"
	debug_button.text = "Mechanic Debug"
	_refresh_aux_panels()
	_refresh_menu_focus()

func _move_menu_selection(direction: int) -> void:
	var controls: Array[Control] = _get_menu_selectables()
	if controls.is_empty():
		return
	menu_selected_index = posmod(menu_selected_index + direction, controls.size())
	_refresh_menu_focus()

func _refresh_menu_focus() -> void:
	var controls: Array[Control] = _get_menu_selectables()
	if controls.is_empty():
		return
	menu_selected_index = clamp(menu_selected_index, 0, controls.size() - 1)
	controls[menu_selected_index].grab_focus()

func _get_menu_selectables() -> Array[Control]:
	var controls: Array[Control] = []
	for control in [primary_button, secondary_button, settings_button, controls_button, debug_button]:
		if control.visible:
			controls.append(control)
	if settings_visible:
		controls.append_array(settings_controller.get_selectables())
	if debug_visible:
		controls.append(wrench_mark_button)
		controls.append(enemy_spin_pull_button)
		controls.append(crate_pull_button)
		controls.append(catch_confirm_button)
		controls.append(sky_resistance_button)
	return controls

func _get_focused_menu_control() -> Control:
	var focus_owner := get_viewport().gui_get_focus_owner()
	if focus_owner is Control:
		return focus_owner as Control
	return null

func _activate_selected_menu_option() -> void:
	var focused: Control = _get_focused_menu_control()
	if focused == null:
		_refresh_menu_focus()
		focused = _get_focused_menu_control()
	if focused == null:
		return
	if focused is Button:
		(focused as Button).emit_signal("pressed")
	elif focused is CheckBox:
		var check: CheckBox = focused as CheckBox
		check.button_pressed = not check.button_pressed
		check.emit_signal("toggled", check.button_pressed)

func _on_primary_button_pressed() -> void:
	if menu_actions.is_empty():
		return
	_execute_menu_action(menu_actions[0])

func _on_secondary_button_pressed() -> void:
	if menu_actions.size() < 2:
		return
	_execute_menu_action(menu_actions[1])

func _on_settings_button_pressed() -> void:
	settings_visible = not settings_visible
	if settings_visible:
		controls_visible = false
		debug_visible = false
	_refresh_aux_panels()

func _on_controls_button_pressed() -> void:
	controls_visible = not controls_visible
	if controls_visible:
		settings_visible = false
		debug_visible = false
	_refresh_aux_panels()

func _on_debug_button_pressed() -> void:
	debug_visible = not debug_visible
	if debug_visible:
		settings_visible = false
		controls_visible = false
	_refresh_aux_panels()

func _refresh_aux_panels() -> void:
	settings_panel.visible = settings_visible
	controls_panel.visible = controls_visible
	debug_panel.visible = debug_visible
	controls_button.text = "Controls Toggle (%s)" % ("On" if controls_visible else "Off")
	settings_button.text = "Settings Menu (%s)" % ("On" if settings_visible else "Off")
	debug_button.text = "Mechanic Debug (%s)" % ("On" if debug_visible else "Off")
	_refresh_debug_panel()
	if menu_selected_index >= _get_menu_selectables().size():
		menu_selected_index = max(_get_menu_selectables().size() - 1, 0)
	_refresh_menu_focus()

func _refresh_debug_panel() -> void:
	debug_controller.refresh_pause_panel()

func _toggle_debug_mechanic(mechanic_id: String) -> void:
	debug_controller.toggle_mechanic(mechanic_id)

func _refresh_separate_debug_menu() -> void:
	debug_controller.refresh_separate_menu()

func _toggle_separate_debug_mechanic(mechanic_id: String) -> void:
	debug_controller.toggle_mechanic(mechanic_id)

func _execute_menu_action(action: String) -> void:
	match action:
		"next_level":
			_load_level(current_level_index + 1, false, false)
		"replay_level":
			_load_level(current_level_index, false, false)
		"restart_run":
			_load_level(0, true, true)
		"resume_pause":
			_resume_from_pause()
		"equip_paper_popper":
			player.unlock_weapon("paper_popper", true)
			_resume_from_pause()
		"unlock_paper_popper_melee":
			player.unlock_weapon("paper_popper", false)
			_resume_from_pause()

func _resume_from_pause() -> void:
	menu_active = false
	menu_mode = ""
	settings_visible = false
	controls_visible = false
	debug_visible = false
	menu_overlay.visible = false
	get_tree().paused = false
	_capture_game_mouse()

func _open_debug_menu() -> void:
	debug_controller.open_menu()
	_sync_mouse_mode_for_menu_state()

func _close_debug_menu() -> void:
	debug_controller.close_menu()
	_sync_mouse_mode_for_menu_state()

func _release_menu_mouse() -> void:
	if Input.get_mouse_mode() != Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _capture_game_mouse() -> void:
	if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _sync_mouse_mode_for_menu_state() -> void:
	if menu_active or debug_controller.is_menu_active():
		_release_menu_mouse()

func _initialize_settings_ui() -> void:
	settings_controller.initialize()

func _refresh_settings_labels() -> void:
	settings_controller.refresh_labels()

func _apply_current_settings_to_player() -> void:
	settings_controller.apply_to_player()
	_refresh_debug_panel()
	_refresh_separate_debug_menu()

func _on_difficulty_changed(new_difficulty_name: String, new_difficulty_scalar: float) -> void:
	level_controller.set_difficulty(new_difficulty_name, new_difficulty_scalar)

func _refresh_controls_text() -> void:
	settings_controller.refresh_controls_text()
