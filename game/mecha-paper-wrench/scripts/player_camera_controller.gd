class_name PlayerCameraController extends Node

signal mode_changed(mode_index: int, mode_name: String)

enum CameraMode {
	DEFAULT,
	LEFT_SHOULDER,
	RIGHT_SHOULDER,
	OVERHEAD,
	FIRST_PERSON,
}

const CAMERA_MODES: Array[int] = [
	CameraMode.DEFAULT,
	CameraMode.LEFT_SHOULDER,
	CameraMode.RIGHT_SHOULDER,
	CameraMode.OVERHEAD,
	CameraMode.FIRST_PERSON,
]

@export var max_camera_pitch_deg: float = 25.0
@export var camera_distance: float = 4.9
@export var camera_height: float = 2.35
@export var camera_default_side_offset: float = 0.72
@export var camera_default_focus_forward: float = 5.8
@export var camera_default_target_height: float = 1.3
@export var camera_default_aim_blend: float = 0.64
@export var initial_mode: CameraMode = CameraMode.DEFAULT

var actor: CharacterBody3D
var camera: Camera3D
var settings: Node
var camera_yaw: float = 0.0
var camera_pitch: float = deg_to_rad(-10.0)
var current_camera_mode: CameraMode = CameraMode.DEFAULT
var shake_timer: float = 0.0
var shake_strength: float = 0.0

func configure(new_actor: CharacterBody3D, new_camera: Camera3D, new_settings: Node) -> void:
	actor = new_actor
	camera = new_camera
	settings = new_settings
	current_camera_mode = initial_mode
	if camera:
		camera.top_level = true

func handle_input(event: InputEvent) -> void:
	if actor == null or camera == null:
		return
	if get_tree() and get_tree().paused:
		return
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED and not _has_locked_target():
		apply_mouse_look(event.relative)
	elif event is InputEventKey and event.pressed and not event.is_echo() and _is_lock_on_toggle_event(event):
		if actor.has_method("toggle_lock_on_target"):
			actor.call("toggle_lock_on_target")
	elif event is InputEventMouseButton and event.pressed and Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func apply_mouse_look(relative_motion: Vector2) -> void:
	camera_yaw -= relative_motion.x * _get_mouse_sensitivity()
	var pitch_delta: float = relative_motion.y * _get_mouse_sensitivity()
	camera_pitch += pitch_delta if _is_invert_y_enabled() else -pitch_delta
	camera_pitch = clamp(camera_pitch, deg_to_rad(-max_camera_pitch_deg), deg_to_rad(15.0))

func tick(delta: float) -> void:
	if actor == null or camera == null:
		return
	_update_shake(delta)
	var focus: Vector3 = actor.global_position + Vector3.UP * 1.12
	var aim_focus: Vector3 = focus + get_camera_aim_direction() * camera_default_focus_forward
	aim_focus.y = max(aim_focus.y, actor.global_position.y + camera_default_target_height)
	var target_focus: Vector3 = focus.lerp(aim_focus, clamp(camera_default_aim_blend, 0.0, 1.0))
	var locked_target: Node3D = _get_locked_target()
	if locked_target and is_instance_valid(locked_target):
		target_focus = aim_focus.lerp(locked_target.global_position + Vector3.UP * 1.0, 0.62)

	var yaw_basis: Basis = Basis(Vector3.UP, camera_yaw)
	var pitch_basis: Basis = Basis(Vector3.RIGHT, camera_pitch)
	var raw_aim_direction: Vector3 = get_raw_aim_direction()
	var desired_pos: Vector3 = camera.global_position
	var look_target: Vector3 = target_focus
	var target_fov: float = 65.0
	var smoothing: float = 10.0

	match current_camera_mode:
		CameraMode.LEFT_SHOULDER:
			desired_pos = focus + yaw_basis * (pitch_basis * Vector3(-1.5, camera_height - 0.15, camera_distance - 0.95))
		CameraMode.RIGHT_SHOULDER:
			desired_pos = focus + yaw_basis * (pitch_basis * Vector3(1.5, camera_height - 0.15, camera_distance - 0.95))
		CameraMode.OVERHEAD:
			desired_pos = focus + Vector3(0.0, 15.0, 0.4)
			look_target = actor.global_position
			target_fov = 58.0
			smoothing = 8.0
		CameraMode.FIRST_PERSON:
			var eye: Vector3 = actor.global_position + Vector3.UP * 1.48
			desired_pos = eye + yaw_basis * Vector3(0.04, 0.0, 0.08)
			look_target = desired_pos + raw_aim_direction * 20.0
			target_fov = 74.0
			smoothing = 18.0
		_:
			desired_pos = focus + yaw_basis * (pitch_basis * Vector3(camera_default_side_offset, camera_height, camera_distance))

	var fov_scale: float = settings.get_camera_fov_scale() if settings else 1.0
	target_fov *= fov_scale
	var position_weight: float = clamp(delta * smoothing, 0.0, 1.0)
	var fov_weight: float = clamp(delta * 8.0, 0.0, 1.0)
	camera.global_position = camera.global_position.lerp(desired_pos + _get_shake_offset(), position_weight)
	camera.fov = lerp(camera.fov, target_fov, fov_weight)
	camera.look_at(look_target + _get_shake_offset() * 0.2, Vector3.UP)

func get_camera_crosshair_target(max_distance: float = 120.0) -> Vector3:
	if camera and camera.is_inside_tree():
		var viewport: Viewport = camera.get_viewport()
		if viewport:
			var screen_center: Vector2 = viewport.get_visible_rect().size * 0.5
			var ray_origin: Vector3 = camera.project_ray_origin(screen_center)
			var ray_direction: Vector3 = camera.project_ray_normal(screen_center).normalized()
			var ray_end: Vector3 = ray_origin + ray_direction * max_distance
			var query := PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
			query.collide_with_areas = false
			query.collide_with_bodies = true
			query.hit_from_inside = true
			query.exclude = [actor.get_rid()]
			var hit: Dictionary = actor.get_world_3d().direct_space_state.intersect_ray(query)
			if not hit.is_empty():
				return hit.position
			return ray_end
	return actor.global_position + get_raw_aim_direction() * max_distance

func get_raw_aim_direction() -> Vector3:
	var yaw_basis: Basis = Basis(Vector3.UP, camera_yaw)
	var pitch_basis: Basis = Basis(Vector3.RIGHT, camera_pitch)
	var aim_dir: Vector3 = yaw_basis * (pitch_basis * Vector3.FORWARD)
	if aim_dir.length_squared() < 0.001:
		return -actor.global_transform.basis.z.normalized()
	return aim_dir.normalized()

func get_camera_aim_direction() -> Vector3:
	var launch_origin: Vector3 = actor.global_position + Vector3.UP * 1.1
	var locked_target: Node3D = _get_locked_target()
	if locked_target and is_instance_valid(locked_target):
		var to_target: Vector3 = (locked_target.global_position + Vector3.UP * 1.0) - launch_origin
		if to_target.length_squared() > 0.001:
			return to_target.normalized()
	var to_crosshair: Vector3 = get_camera_crosshair_target() - launch_origin
	if to_crosshair.length_squared() > 0.001:
		return to_crosshair.normalized()
	return get_raw_aim_direction()

func cycle_camera_mode() -> void:
	var current_index: int = CAMERA_MODES.find(int(current_camera_mode))
	if current_index == -1:
		current_index = 0
	set_camera_mode(CAMERA_MODES[(current_index + 1) % CAMERA_MODES.size()])

func get_camera_yaw() -> float:
	return camera_yaw

func set_camera_yaw(value: float) -> void:
	camera_yaw = value

func get_camera_pitch() -> float:
	return camera_pitch

func set_camera_pitch(value: float) -> void:
	camera_pitch = clamp(value, deg_to_rad(-max_camera_pitch_deg), deg_to_rad(15.0))

func set_camera_mode(mode_index: int) -> void:
	if mode_index < 0 or mode_index >= CAMERA_MODES.size():
		mode_index = CameraMode.DEFAULT
	var mode_changed_now: bool = current_camera_mode != mode_index
	current_camera_mode = mode_index
	if mode_changed_now and current_camera_mode == CameraMode.FIRST_PERSON:
		_snap_to_first_person_pose()
	mode_changed.emit(get_camera_mode_index(), get_camera_mode_name())

func _snap_to_first_person_pose() -> void:
	if actor == null or camera == null:
		return
	var yaw_basis: Basis = Basis(Vector3.UP, camera_yaw)
	var desired_pos: Vector3 = actor.global_position + Vector3.UP * 1.48 + yaw_basis * Vector3(0.04, 0.0, 0.08)
	camera.global_position = desired_pos
	camera.look_at(desired_pos + get_raw_aim_direction() * 20.0, Vector3.UP)

func get_camera_mode_index() -> int:
	return int(current_camera_mode)

func get_camera_mode_name() -> String:
	match current_camera_mode:
		CameraMode.LEFT_SHOULDER:
			return "Shoulder Left"
		CameraMode.RIGHT_SHOULDER:
			return "Shoulder Right"
		CameraMode.OVERHEAD:
			return "Overhead"
		CameraMode.FIRST_PERSON:
			return "First Person (Experimental)"
		_:
			return "Default"

func trigger_shake(duration: float, strength: float) -> void:
	if not _is_camera_shake_enabled():
		return
	shake_timer = max(shake_timer, duration)
	shake_strength = max(shake_strength, strength)

func reset_transient_state() -> void:
	shake_timer = 0.0
	shake_strength = 0.0

func _update_shake(delta: float) -> void:
	if shake_timer <= 0.0:
		return
	shake_timer -= delta
	if shake_timer <= 0.0:
		shake_strength = 0.0

func _get_shake_offset() -> Vector3:
	if shake_timer <= 0.0 or shake_strength <= 0.0:
		return Vector3.ZERO
	return Vector3(
		randf_range(-shake_strength, shake_strength),
		randf_range(-shake_strength * 0.7, shake_strength * 0.7),
		randf_range(-shake_strength, shake_strength)
	)

func _get_mouse_sensitivity() -> float:
	return settings.get_mouse_sensitivity() if settings else 0.0032

func _is_invert_y_enabled() -> bool:
	return settings.is_invert_look_y_enabled() if settings else false

func _is_camera_shake_enabled() -> bool:
	return settings.is_camera_shake_enabled() if settings else true

func _has_locked_target() -> bool:
	return actor.has_method("has_locked_target") and actor.call("has_locked_target")

func _get_locked_target() -> Node3D:
	if actor.has_method("get_locked_target"):
		return actor.call("get_locked_target") as Node3D
	return null

func _is_lock_on_toggle_event(event: InputEventKey) -> bool:
	if actor.has_method("is_lock_on_enabled") and not actor.call("is_lock_on_enabled"):
		return false
	return event.is_action_pressed("lock_on") or event.physical_keycode == 4194308 or event.keycode == 4194308
