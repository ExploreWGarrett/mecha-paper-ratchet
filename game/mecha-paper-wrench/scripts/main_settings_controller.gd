class_name MainSettingsController extends Node

signal difficulty_changed(difficulty_name: String, difficulty_scalar: float)

const DEFAULT_MASTER_VOLUME_PERCENT := 10.0
const DEFAULT_DIFFICULTY_NAME := "Normal"
const DEFAULT_DIFFICULTY_SCALAR := 1.0
const DIFFICULTY_PRESETS := {
	"Easy": 0.75,
	"Normal": 1.0,
	"Hard": 1.35,
	"Brutal": 1.7,
}
const CONTROL_TEXT_TEMPLATE := "Mecha Paper Wrench prototype\n\nMouse = camera\nWASD = move\nSpace = jump / hold while falling = feather fall\nDouble jump once in air\nHold Shift = crouch / tap Shift while moving forward = roll\nMidair Shift = one air dodge per jump\nLMB / J = attack or weapon primary\nRMB = spin attack or weapon secondary\n%s = wrench throw ability slot\nMMB = fallback melee / air pound while armed\nV = fallback melee secondary while armed\nT = toggle armed stance / full-time melee\nN = cycle camera position\nR or Tab = lock-on\nEsc = pause / settings menu\n~ = mechanic debug menu\n\nMenu nav: W/S or A/D = select, Space = confirm, A/D = adjust sliders"

var player: Node
var crosshair_label: Label
var controls_panel: RichTextLabel
var volume_slider: HSlider
var volume_value_label: Label
var sensitivity_slider: HSlider
var sensitivity_value_label: Label
var fov_slider: HSlider
var fov_value_label: Label
var difficulty_slider: HSlider
var difficulty_value_label: Label
var camera_mode_button: Button
var boomerang_slot_button: Button
var invert_y_check: CheckBox
var crosshair_check: CheckBox
var camera_shake_check: CheckBox
var difficulty_name: String = DEFAULT_DIFFICULTY_NAME
var difficulty_scalar: float = DEFAULT_DIFFICULTY_SCALAR

func configure(new_player: Node, new_crosshair_label: Label, new_controls_panel: RichTextLabel, controls: Dictionary) -> void:
	player = new_player
	crosshair_label = new_crosshair_label
	controls_panel = new_controls_panel
	volume_slider = controls["volume_slider"]
	volume_value_label = controls["volume_value_label"]
	sensitivity_slider = controls["sensitivity_slider"]
	sensitivity_value_label = controls["sensitivity_value_label"]
	fov_slider = controls["fov_slider"]
	fov_value_label = controls["fov_value_label"]
	difficulty_slider = controls["difficulty_slider"]
	difficulty_value_label = controls["difficulty_value_label"]
	camera_mode_button = controls["camera_mode_button"]
	boomerang_slot_button = controls["boomerang_slot_button"]
	invert_y_check = controls["invert_y_check"]
	crosshair_check = controls["crosshair_check"]
	camera_shake_check = controls["camera_shake_check"]
	volume_slider.value_changed.connect(_on_volume_slider_changed)
	sensitivity_slider.value_changed.connect(_on_sensitivity_slider_changed)
	fov_slider.value_changed.connect(_on_fov_slider_changed)
	difficulty_slider.value_changed.connect(_on_difficulty_slider_changed)
	camera_mode_button.pressed.connect(_on_camera_mode_button_pressed)
	boomerang_slot_button.pressed.connect(_on_boomerang_slot_button_pressed)
	invert_y_check.toggled.connect(_on_invert_y_toggled)
	crosshair_check.toggled.connect(_on_crosshair_toggled)
	camera_shake_check.toggled.connect(_on_camera_shake_toggled)

func initialize() -> void:
	volume_slider.value = DEFAULT_MASTER_VOLUME_PERCENT
	_on_volume_slider_changed(DEFAULT_MASTER_VOLUME_PERCENT)
	if player:
		sensitivity_slider.value = player.get_mouse_sensitivity()
		fov_slider.value = player.get_camera_fov_scale()
		invert_y_check.button_pressed = player.is_invert_look_y_enabled()
		camera_shake_check.button_pressed = player.is_camera_shake_enabled()
	difficulty_slider.value = difficulty_scalar
	crosshair_check.button_pressed = true
	refresh_labels()
	apply_to_player()
	difficulty_changed.emit(difficulty_name, difficulty_scalar)

func get_selectables() -> Array[Control]:
	return [volume_slider, sensitivity_slider, fov_slider, difficulty_slider, camera_mode_button, boomerang_slot_button, invert_y_check, crosshair_check, camera_shake_check]

func refresh_labels() -> void:
	volume_value_label.text = "%d%%" % int(round(volume_slider.value))
	sensitivity_value_label.text = "%.4f" % sensitivity_slider.value
	fov_value_label.text = "%.2fx" % fov_slider.value
	difficulty_value_label.text = "%s (%.2f)" % [_get_difficulty_label_for_scalar(difficulty_scalar), difficulty_scalar]
	if player and player.has_method("get_camera_mode_name"):
		camera_mode_button.text = "%s  ->" % player.get_camera_mode_name()
	if player and player.has_method("get_boomerang_ability_slot_label"):
		boomerang_slot_button.text = "%s  ->" % player.get_boomerang_ability_slot_label()
	refresh_controls_text()

func apply_to_player() -> void:
	if not player:
		return
	player.set_mouse_sensitivity(sensitivity_slider.value)
	player.set_camera_fov_scale(fov_slider.value)
	player.set_invert_look_y(invert_y_check.button_pressed)
	player.set_camera_shake_enabled(camera_shake_check.button_pressed)
	if crosshair_label:
		crosshair_label.visible = crosshair_check.button_pressed
	refresh_labels()

func refresh_controls_text() -> void:
	if controls_panel == null:
		return
	var key_label: String = "E"
	if player and player.has_method("get_boomerang_ability_slot_label"):
		key_label = player.get_boomerang_ability_slot_label()
	controls_panel.text = CONTROL_TEXT_TEMPLATE % key_label

func _on_volume_slider_changed(value: float) -> void:
	var master_bus: int = AudioServer.get_bus_index("Master")
	if value <= 0.0:
		AudioServer.set_bus_volume_db(master_bus, -80.0)
	else:
		AudioServer.set_bus_volume_db(master_bus, linear_to_db(value / 100.0))
	refresh_labels()

func _on_sensitivity_slider_changed(value: float) -> void:
	if player:
		player.set_mouse_sensitivity(value)
	refresh_labels()

func _on_fov_slider_changed(value: float) -> void:
	if player:
		player.set_camera_fov_scale(value)
	refresh_labels()

func _on_difficulty_slider_changed(value: float) -> void:
	difficulty_scalar = clamp(snappedf(value, 0.05), difficulty_slider.min_value, difficulty_slider.max_value)
	difficulty_name = _get_difficulty_label_for_scalar(difficulty_scalar)
	difficulty_slider.value = difficulty_scalar
	difficulty_changed.emit(difficulty_name, difficulty_scalar)
	refresh_labels()

func _on_camera_mode_button_pressed() -> void:
	if player and player.has_method("cycle_camera_mode"):
		player.cycle_camera_mode()
	refresh_labels()

func _on_camera_shake_toggled(toggled_on: bool) -> void:
	if player:
		player.set_camera_shake_enabled(toggled_on)

func _on_invert_y_toggled(toggled_on: bool) -> void:
	if player:
		player.set_invert_look_y(toggled_on)

func _on_crosshair_toggled(toggled_on: bool) -> void:
	if crosshair_label:
		crosshair_label.visible = toggled_on

func _on_boomerang_slot_button_pressed() -> void:
	if player and player.has_method("cycle_boomerang_ability_slot_action"):
		player.cycle_boomerang_ability_slot_action()
	refresh_labels()

func _get_difficulty_label_for_scalar(value: float) -> String:
	for preset_name in DIFFICULTY_PRESETS.keys():
		if abs(float(DIFFICULTY_PRESETS[preset_name]) - value) < 0.026:
			return preset_name
	return "Custom"
