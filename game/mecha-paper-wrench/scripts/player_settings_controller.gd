class_name PlayerSettingsController extends Node

signal changed

@export var mouse_sensitivity: float = 0.0032
@export var invert_look_y: bool = false
@export var camera_fov_scale: float = 1.0
@export var camera_shake_enabled: bool = true

func set_mouse_sensitivity(value: float) -> void:
	mouse_sensitivity = clamp(value, 0.001, 0.01)
	changed.emit()

func get_mouse_sensitivity() -> float:
	return mouse_sensitivity

func set_invert_look_y(enabled: bool) -> void:
	invert_look_y = enabled
	changed.emit()

func is_invert_look_y_enabled() -> bool:
	return invert_look_y

func set_camera_fov_scale(value: float) -> void:
	camera_fov_scale = clamp(value, 0.75, 1.35)
	changed.emit()

func get_camera_fov_scale() -> float:
	return camera_fov_scale

func set_camera_shake_enabled(enabled: bool) -> void:
	camera_shake_enabled = enabled
	changed.emit()

func is_camera_shake_enabled() -> bool:
	return camera_shake_enabled
