extends CharacterBody3D

const BOOMERANG_SCENE := preload("res://scenes/Boomerang.tscn")
const PLAYER_PROJECTILE_SCENE := preload("res://scenes/PaperPopperProjectile.tscn")
const FIRST_PERSON_CAMERA_MODE := 4

const ABILITY_WRENCH_THROW := "wrench_throw"
const DEBUG_MECHANIC_ORDER: Array[String] = ["double_jump", "high_jump", "long_jump", "feather_fall", "roll", "air_dodge", "ground_pound", "wrench_throw", "lock_on", "paper_popper", "weapon_stance", "wrench_mark", "enemy_spin_pull", "crate_pull", "catch_confirm", "sky_resistance", "camera_shake"]

const WEAPON_PAPER_POPPER := "paper_popper"
const WEAPON_UNLOCK_XP := 50

@export var walk_speed: float = 6.2
@export var strafe_speed: float = 5.8
@export var acceleration: float = 16.0
@export var jump_velocity: float = 7.2
@export var double_jump_velocity: float = 7.0
@export var high_jump_velocity: float = 14.2
@export var long_jump_forward_speed: float = 15.5
@export var long_jump_vertical_speed: float = 8.6
@export var roll_speed: float = 12.0
@export var roll_time: float = 0.42
@export var air_dodge_speed: float = 14.0
@export var air_dodge_time: float = 0.26
@export var movement_lock_time: float = 0.24
@export var ground_pound_speed: float = 19.0
@export var arena_radius: float = 11.5
@export var slow_fall_gravity_scale: float = 0.35
@export var jump_hold_gravity_scale: float = 0.72
@export var crouch_move_speed_scale: float = 0.42
@export var boomerang_throw_distance: float = 11.0
@export var projectile_spawn_center_blend: float = 0.62
@export var spin_pull_yank_floor_distance: float = 1.05
@export var max_health: int = 8
@export var invincibility_time: float = 0.75
@export var xp_attract_radius: float = 5.5
@export var xp_collect_radius: float = 1.0
@export var money_collect_radius: float = 1.05
@export var fall_respawn_y: float = -8.0
@export var fall_respawn_health_loss_ratio: float = 0.25
@export var sky_resistance_enabled: bool = true
@export var sky_resistance_start_y: float = 10.0
@export var sky_resistance_band_height: float = 3.5
@export var sky_resistance_upward_drag: float = 26.0
@export var sky_resistance_downward_pull: float = 18.0
@export var crate_shove_mass: float = 1.25
@export var wrench_combo_mark_enabled: bool = true
@export var wrench_combo_mark_duration: float = 4.5
@export var wrench_spin_pull_enabled: bool = false
@export var wrench_spin_pull_radius: float = 4.2
@export var wrench_spin_pull_strength: float = 4.4
@export var wrench_spin_pull_yank_step: float = 1.1
@export var standing_spin_hit_radius: float = 3.15
@export var standing_spin_height_tolerance: float = 1.55
@export var wrench_crouch_spin_pull_radius: float = 4.8
@export var wrench_crouch_spin_pull_strength: float = 5.0
@export var wrench_crouch_spin_pull_yank_step: float = 1.45
@export var crouch_spin_hit_radius: float = 3.35
@export var crouch_spin_height_tolerance: float = 0.48
@export var wrench_crate_pull_enabled: bool = true
@export var wrench_crate_pull_radius: float = 3.8
@export var wrench_crate_pull_strength: float = 3.8
@export var wrench_crate_pull_yank_step: float = 0.85
@export var wrench_crouch_crate_pull_enabled: bool = true
@export var wrench_crouch_crate_pull_radius: float = 4.6
@export var wrench_crouch_crate_pull_strength: float = 4.6
@export var wrench_crouch_crate_pull_yank_step: float = 1.15
@export var wrench_catch_confirm_enabled: bool = true
@export var wrench_catch_confirm_duration: float = 4.0
@export var wrench_catch_confirm_bonus_damage: int = 1
@export var wrench_catch_confirm_mark_bonus_damage: int = 1

var arena_shape_mode: String = "circle"
var arena_square_half_extents: Vector2 = Vector2(11.5, 11.5)
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var yaw: float = 0.0
var locked_target: Node3D = null
var combo_step: int = 0
var combo_reset_timer: float = 0.0
var attack_cooldown: float = 0.0
var attack_anim_timer: float = 0.0
var attack_anim_kind: String = ""
var hit_confirm_timer: float = 0.0
var roll_timer: float = 0.0
var movement_lock_timer: float = 0.0
var roll_direction: Vector3 = Vector3.ZERO
var ground_pound_active: bool = false
var air_attack_used: bool = false
var air_dodge_used: bool = false
var jumps_used: int = 0
var was_on_floor: bool = true
var boomerang_in_flight: bool = false
var facing_direction: Vector3 = Vector3.FORWARD
var ground_pound_pending_impact: bool = false
var current_health: int = max_health
var xp_current: int = 0
var money_current: int = 0
var total_xp_earned: int = 0
var invincibility_timer: float = 0.0
var spawn_position: Vector3 = Vector3.ZERO
var wrench_throw_enabled: bool = true
var double_jump_enabled: bool = true
var high_jump_enabled: bool = true
var long_jump_enabled: bool = true
var feather_fall_enabled: bool = true
var roll_enabled: bool = true
var air_dodge_enabled: bool = true
var ground_pound_enabled: bool = true
var lock_on_enabled: bool = true
var paper_popper_enabled: bool = true
var weapon_stance_toggle_enabled: bool = true
var unlocked_weapon_ids: Array[String] = []
var active_weapon_id: String = ""
var weapon_stance_active: bool = false
var weapon_primary_cooldown: float = 0.0
var weapon_secondary_cooldown: float = 0.0
var muzzle_flash_timer: float = 0.0
var catch_confirm_timer: float = 0.0
var catch_confirm_ready: bool = false
var status_notice_timer: float = 0.0

@onready var camera: Camera3D = $Camera3D
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var visual_root: Node3D = $VisualRoot
@onready var paper_mesh: MeshInstance3D = $VisualRoot/PaperMesh
@onready var weapon_root: Node3D = $VisualRoot/WeaponRoot
@onready var wrench_handle: MeshInstance3D = $VisualRoot/WeaponRoot/Handle
@onready var wrench_mesh: MeshInstance3D = $VisualRoot/WeaponRoot/WrenchMesh
@onready var pistol_root: Node3D = $VisualRoot/WeaponRoot/PistolRoot
@onready var pistol_body: MeshInstance3D = $VisualRoot/WeaponRoot/PistolRoot/PistolBody
@onready var pistol_barrel: MeshInstance3D = $VisualRoot/WeaponRoot/PistolRoot/PistolBarrel
@onready var muzzle_point: Marker3D = $VisualRoot/WeaponRoot/PistolRoot/MuzzlePoint
@onready var muzzle_flash: MeshInstance3D = $VisualRoot/WeaponRoot/PistolRoot/MuzzleFlash
@onready var crouch_indicator: MeshInstance3D = $CrouchIndicator
@onready var lock_indicator: MeshInstance3D = $LockIndicator
@onready var state_indicator: MeshInstance3D = $StateIndicator
@onready var standing_spin_preview: MeshInstance3D = $StandingSpinPreview
@onready var crouch_spin_preview: MeshInstance3D = $CrouchSpinPreview
@onready var hit_confirm_audio: AudioStreamPlayer = $HitConfirmAudio
@onready var hurt_audio: AudioStreamPlayer = $HurtAudio
@onready var settings_controller: Node = $SettingsController
@onready var camera_controller: Node = $CameraController
@onready var ability_controller: Node = $AbilityController
@onready var combat_controller: Node = $CombatController
var status_label: Label = null
var player_health_bar: ProgressBar = null
var status_notice_label: Label = null

func _ready() -> void:
	add_to_group("player")
	randomize()
	camera_controller.configure(self, camera, settings_controller)
	ability_controller.notice_requested.connect(_show_status_notice)
	ability_controller.loadout_changed.connect(_refresh_hud)
	combat_controller.configure(self)
	crouch_indicator.visible = false
	lock_indicator.visible = false
	state_indicator.visible = false
	standing_spin_preview.visible = false
	crouch_spin_preview.visible = false
	muzzle_flash.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	spawn_position = global_position
	current_health = max_health
	_reset_ability_assignments()
	unlock_ability(ABILITY_WRENCH_THROW, true)
	_ensure_hud_refs()
	_refresh_weapon_visual_state()
	_refresh_hud()

func _unhandled_input(event: InputEvent) -> void:
	camera_controller.handle_input(event)

func _physics_process(delta: float) -> void:
	var on_floor_before_move: bool = is_on_floor()

	if combo_reset_timer > 0.0:
		combo_reset_timer -= delta
		if combo_reset_timer <= 0.0:
			combo_step = 0

	if attack_cooldown > 0.0:
		attack_cooldown -= delta
	if attack_anim_timer > 0.0:
		attack_anim_timer -= delta
	if hit_confirm_timer > 0.0:
		hit_confirm_timer -= delta
	if movement_lock_timer > 0.0:
		movement_lock_timer -= delta
	if invincibility_timer > 0.0:
		invincibility_timer -= delta

	if weapon_primary_cooldown > 0.0:
		weapon_primary_cooldown -= delta
	if weapon_secondary_cooldown > 0.0:
		weapon_secondary_cooldown -= delta
	if status_notice_timer > 0.0:
		status_notice_timer -= delta
		if status_notice_timer <= 0.0 and status_notice_label:
			status_notice_label.text = ""
	if not wrench_catch_confirm_enabled and (catch_confirm_ready or catch_confirm_timer > 0.0):
		catch_confirm_ready = false
		catch_confirm_timer = 0.0
	elif catch_confirm_timer > 0.0:
		catch_confirm_timer -= delta
		if catch_confirm_timer <= 0.0:
			catch_confirm_timer = 0.0
			catch_confirm_ready = false
	if muzzle_flash_timer > 0.0:
		muzzle_flash_timer -= delta
		if muzzle_flash_timer <= 0.0:
			muzzle_flash.visible = false

	if roll_timer > 0.0:
		roll_timer -= delta
		velocity.x = roll_direction.x * _current_dodge_speed()
		velocity.z = roll_direction.z * _current_dodge_speed()
	else:
		_handle_inputs(delta, on_floor_before_move)

	if not on_floor_before_move:
		var gravity_scale: float = 1.0
		if Input.is_action_pressed("jump") and not ground_pound_active:
			if velocity.y > 0.0:
				gravity_scale = jump_hold_gravity_scale
			elif feather_fall_enabled:
				gravity_scale = slow_fall_gravity_scale
		velocity.y -= gravity * gravity_scale * delta
		_apply_sky_resistance(delta)
	else:
		air_attack_used = false
		if velocity.y < 0.0:
			velocity.y = -0.1

	if ground_pound_active:
		velocity.y = -ground_pound_speed

	move_and_slide()
	_clamp_to_arena()
	if global_position.y <= fall_respawn_y:
		_handle_fall_respawn()
		return
	_validate_lock_target()

	var on_floor_after_move: bool = is_on_floor()
	if on_floor_after_move and ground_pound_pending_impact:
		_resolve_ground_pound_impact()
	if on_floor_after_move and not was_on_floor:
		jumps_used = 0
		air_dodge_used = false
		movement_lock_timer = 0.0
	elif not on_floor_after_move and was_on_floor and jumps_used == 0:
		jumps_used = 1
	was_on_floor = on_floor_after_move

	_update_xp_orbs(delta)
	_update_money_pickups(delta)
	_update_visuals(delta)
	_update_camera(delta)
	_refresh_hud()

func _handle_inputs(delta: float, on_floor_before_move: bool) -> void:
	if Input.is_action_just_pressed("cycle_camera_mode"):
		cycle_camera_mode()
	if Input.is_action_just_pressed("toggle_weapon_mode"):
		toggle_weapon_mode()
	combat_controller.handle_assigned_ability_input()

	var input_vec: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var crouching: bool = on_floor_before_move and Input.is_action_pressed("crouch")
	var desired_velocity: Vector3 = Vector3.ZERO

	if air_dodge_enabled and not on_floor_before_move and Input.is_action_just_pressed("crouch") and not air_dodge_used:
		_start_air_dodge(input_vec)
		return

	if roll_enabled and on_floor_before_move and Input.is_action_just_pressed("crouch") and input_vec.y < -0.25:
		_start_roll()
		return

	if Input.is_action_just_pressed("jump"):
		if on_floor_before_move:
			if crouching and input_vec.y < -0.25 and long_jump_enabled:
				_do_long_jump()
				return
			elif crouching and high_jump_enabled:
				_do_high_jump()
				return
			velocity.y = jump_velocity
			jumps_used = 1
			attack_anim_kind = "jump"
			attack_anim_timer = 0.2
		elif double_jump_enabled and jumps_used < 2:
			velocity.y = double_jump_velocity
			jumps_used += 1
			attack_anim_kind = "double_jump"
			attack_anim_timer = 0.28

	combat_controller.handle_input(on_floor_before_move, crouching)

	if movement_lock_timer <= 0.0:
		if locked_target:
			var to_target: Vector3 = locked_target.global_position - global_position
			to_target.y = 0.0
			if to_target.length_squared() > 0.001:
				to_target = to_target.normalized()
				facing_direction = to_target
				yaw = atan2(-to_target.x, -to_target.z)
				if camera_controller.get_camera_mode_index() != FIRST_PERSON_CAMERA_MODE:
					camera_controller.set_camera_yaw(yaw)
				var right: Vector3 = to_target.cross(Vector3.UP).normalized()
				desired_velocity = (right * input_vec.x + to_target * -input_vec.y) * strafe_speed
		else:
			var cam_basis: Basis = Basis(Vector3.UP, camera_controller.get_camera_yaw())
			var forward: Vector3 = -cam_basis.z
			var right: Vector3 = cam_basis.x
			forward.y = 0.0
			right.y = 0.0
			forward = forward.normalized()
			right = right.normalized()
			var move_dir: Vector3 = right * input_vec.x + forward * -input_vec.y
			if move_dir.length_squared() > 0.001:
				move_dir = move_dir.normalized()
				desired_velocity = move_dir * walk_speed
				facing_direction = move_dir
				yaw = atan2(-move_dir.x, -move_dir.z)
			else:
				facing_direction = forward
				yaw = lerp_angle(yaw, camera_controller.get_camera_yaw(), delta * 10.0)

		velocity.x = move_toward(velocity.x, desired_velocity.x, acceleration * delta)
		velocity.z = move_toward(velocity.z, desired_velocity.z, acceleration * delta)

		if crouching:
			velocity.x *= crouch_move_speed_scale
			velocity.z *= crouch_move_speed_scale

func _handle_primary_melee_action(on_floor_before_move: bool, crouching: bool) -> void:
	if boomerang_in_flight:
		_do_throw_state_punch_attack()
		return
	if ground_pound_enabled and not on_floor_before_move and not air_attack_used:
		_start_ground_pound()
	else:
		_do_melee_combo()

func _handle_secondary_melee_action(on_floor_before_move: bool, crouching: bool) -> void:
	if boomerang_in_flight:
		_do_throw_state_spin_attack()
		return
	if not on_floor_before_move:
		return
	if crouching:
		_do_crouch_spin_attack()
	else:
		_do_spin_attack()

func _do_melee_combo() -> void:
	if attack_cooldown > 0.0:
		return
	var radius_scale: float = _current_melee_radius_scale()
	var damage_scale: float = _current_melee_damage_scale()
	combo_step = clamp(combo_step + 1, 1, 3)
	combo_reset_timer = 0.7
	attack_cooldown = 0.2 if combo_step < 3 else 0.42
	if combo_step == 1:
		attack_anim_kind = "slash_1"
		attack_anim_timer = 0.2
		_melee_hit(2.45 * radius_scale, 95.0, max(1, int(round(1.0 * damage_scale))))
	elif combo_step == 2:
		attack_anim_kind = "slash_2"
		attack_anim_timer = 0.22
		_melee_hit(2.55 * radius_scale, 115.0, max(1, int(round(1.0 * damage_scale))))
	else:
		attack_anim_kind = "spin"
		attack_anim_timer = 0.36
		var finisher_options: Dictionary = {}
		if wrench_combo_mark_enabled:
			finisher_options["apply_wrench_mark"] = true
			finisher_options["mark_duration"] = wrench_combo_mark_duration
		_melee_hit(2.9 * radius_scale, 180.0, max(1, int(round(2.0 * damage_scale))), finisher_options)
		combo_step = 0
		combo_reset_timer = 0.0

func _do_spin_attack() -> void:
	if attack_cooldown > 0.0:
		return
	combo_step = 0
	combo_reset_timer = 0.0
	attack_cooldown = 0.55
	attack_anim_kind = "secondary_spin"
	attack_anim_timer = 0.45
	if wrench_spin_pull_enabled and wrench_spin_pull_strength > 0.0 and wrench_spin_pull_radius > 0.0:
		_apply_spin_pull_window(wrench_spin_pull_radius, wrench_spin_pull_strength, wrench_spin_pull_yank_step)
	if wrench_crate_pull_enabled and wrench_crate_pull_strength > 0.0 and wrench_crate_pull_radius > 0.0:
		_apply_crate_pull_window(wrench_crate_pull_radius, wrench_crate_pull_strength, wrench_crate_pull_yank_step)
	_melee_hit(standing_spin_hit_radius * _current_melee_radius_scale(), 240.0, max(1, int(round(2.0 * _current_melee_damage_scale()))), {"height_tolerance": standing_spin_height_tolerance})

func _do_crouch_spin_attack() -> void:
	if attack_cooldown > 0.0:
		return
	combo_step = 0
	combo_reset_timer = 0.0
	attack_cooldown = 0.62
	attack_anim_kind = "crouch_spin"
	attack_anim_timer = 0.52
	if wrench_spin_pull_enabled and wrench_crouch_spin_pull_strength > 0.0 and wrench_crouch_spin_pull_radius > 0.0:
		_apply_spin_pull_window(wrench_crouch_spin_pull_radius, wrench_crouch_spin_pull_strength, wrench_crouch_spin_pull_yank_step)
	if wrench_crouch_crate_pull_enabled and wrench_crouch_crate_pull_strength > 0.0 and wrench_crouch_crate_pull_radius > 0.0:
		_apply_crate_pull_window(wrench_crouch_crate_pull_radius, wrench_crouch_crate_pull_strength, wrench_crouch_crate_pull_yank_step)
	_melee_hit(crouch_spin_hit_radius * _current_melee_radius_scale(), 360.0, max(1, int(round(2.0 * _current_melee_damage_scale()))), {"height_tolerance": crouch_spin_height_tolerance})

func _do_throw_state_punch_attack() -> void:
	if attack_cooldown > 0.0:
		return
	combo_step = 0
	combo_reset_timer = 0.0
	attack_cooldown = 0.16
	attack_anim_kind = "throw_punch"
	attack_anim_timer = 0.14
	_melee_hit(1.55, 88.0, 1)

func _do_throw_state_spin_attack() -> void:
	if attack_cooldown > 0.0:
		return
	combo_step = 0
	combo_reset_timer = 0.0
	attack_cooldown = 0.34
	attack_anim_kind = "throw_spin"
	attack_anim_timer = 0.24
	_melee_hit(2.05, 220.0, 1)

func _melee_hit(radius: float, arc_deg: float, damage: int, options: Dictionary = {}) -> void:
	var hit_any: bool = false
	var empowered_hit_used: bool = false
	var mark_applied_any: bool = false
	var apply_wrench_mark: bool = options.get("apply_wrench_mark", false)
	var mark_duration: float = options.get("mark_duration", wrench_combo_mark_duration)
	var height_tolerance: float = options.get("height_tolerance", 1.15)
	for group_name in ["enemy", "destructible"]:
		for target in get_tree().get_nodes_in_group(group_name):
			if not target.has_method("take_damage"):
				continue
			var to_enemy: Vector3 = target.global_position - global_position
			var vertical_offset: float = abs(to_enemy.y)
			to_enemy.y = 0.0
			var distance: float = to_enemy.length()
			if distance > radius or distance < 0.05:
				continue
			if vertical_offset > height_tolerance:
				continue
			var dir: Vector3 = to_enemy.normalized()
			var facing: Vector3 = facing_direction
			facing.y = 0.0
			if facing.length_squared() < 0.01:
				facing = -global_transform.basis.z
			facing = facing.normalized()
			var dot_angle: float = rad_to_deg(acos(clamp(facing.dot(dir), -1.0, 1.0)))
			if arc_deg >= 359.0 or dot_angle <= arc_deg * 0.5:
				var total_damage: int = damage
				if group_name == "enemy" and wrench_catch_confirm_enabled and catch_confirm_ready:
					total_damage += max(wrench_catch_confirm_bonus_damage, 0)
					empowered_hit_used = true
					if target.has_method("consume_wrench_mark") and target.consume_wrench_mark():
						total_damage += max(wrench_catch_confirm_mark_bonus_damage, 0)
				if group_name == "enemy":
					target.take_damage(total_damage)
					if apply_wrench_mark and target.has_method("apply_wrench_mark"):
						target.apply_wrench_mark(mark_duration)
						mark_applied_any = true
				else:
					target.take_damage(total_damage, true, global_position, 10.0 + radius * 1.5)
				hit_any = true
	if empowered_hit_used:
		catch_confirm_ready = false
		catch_confirm_timer = 0.0
		_show_status_notice("Catch Confirm spent", 1.2)
	if mark_applied_any:
		_show_status_notice("Enemy marked", 1.2)
	if hit_any:
		hit_confirm_timer = 0.18
		_play_hit_confirm_feedback()

func _throw_boomerang() -> void:
	if attack_cooldown > 0.0 or boomerang_in_flight:
		return
	var throw_scale: float = 0.82 if _weapon_controls_active() else 1.0
	attack_cooldown = 0.55
	combo_step = 0
	combo_reset_timer = 0.0
	attack_anim_kind = "boomerang"
	attack_anim_timer = 0.42
	boomerang_in_flight = true
	_refresh_weapon_visual_state()

	var launch_origin: Vector3 = global_position + Vector3.UP * 1.1
	var launch_direction: Vector3 = _get_camera_aim_direction()
	var aim_target: Vector3 = launch_origin + launch_direction * boomerang_throw_distance * throw_scale
	var flat_launch: Vector3 = Vector3(launch_direction.x, 0.0, launch_direction.z)
	if flat_launch.length_squared() > 0.001:
		facing_direction = flat_launch.normalized()

	var boomerang = BOOMERANG_SCENE.instantiate()
	boomerang.owner_player = self
	boomerang.thrower = self
	boomerang.configure_launch(launch_direction)
	boomerang.damage = 1
	var scene_root: Node = get_tree().current_scene if get_tree().current_scene else get_tree().root
	scene_root.add_child(boomerang)
	boomerang.global_position = launch_origin + launch_direction * 0.8
	boomerang.start_position = boomerang.global_position
	boomerang.target_position = aim_target

func _trigger_ability_slot_1() -> void:
	if not wrench_throw_enabled or boomerang_in_flight:
		return
	_show_status_notice("Boomerang out [%s]" % get_boomerang_ability_slot_label(), 1.1)
	_throw_boomerang()

func _trigger_assigned_ability(slot_action: StringName) -> void:
	var ability_id: String = ability_controller.get_assigned_ability(slot_action)
	match ability_id:
		ABILITY_WRENCH_THROW:
			_trigger_ability_slot_1()

func _apply_spin_pull_window(pull_radius: float, pull_strength: float, yank_step: float) -> void:
	for target in get_tree().get_nodes_in_group("enemy"):
		if not target.has_method("pull_toward"):
			continue
		var to_target: Vector3 = target.global_position - global_position
		to_target.y = 0.0
		var distance: float = to_target.length()
		if distance < 0.05 or distance > pull_radius:
			continue
		target.pull_toward(global_position, pull_strength, yank_step, spin_pull_yank_floor_distance)

func _apply_crate_pull_window(pull_radius: float, pull_strength: float, yank_step: float) -> void:
	var pulled_any: bool = false
	for crate in get_tree().get_nodes_in_group("crate"):
		if not crate.has_method("pull_toward"):
			continue
		var to_crate: Vector3 = crate.global_position - global_position
		to_crate.y = 0.0
		var distance: float = to_crate.length()
		if distance < 0.05 or distance > pull_radius:
			continue
		var distance_scale: float = clamp(1.0 - distance / max(pull_radius, 0.001), 0.2, 1.0)
		crate.pull_toward(global_position, pull_strength * distance_scale, yank_step * distance_scale, spin_pull_yank_floor_distance)
		pulled_any = true
	if pulled_any:
		_show_status_notice("Crate pull proc", 1.0)

func _reset_ability_assignments() -> void:
	ability_controller.reset()

func unlock_ability(ability_id: String, auto_assign: bool = true) -> void:
	ability_controller.unlock_ability(ability_id, auto_assign)
	_refresh_hud()

func assign_ability_to_slot(ability_id: String, slot_action: StringName, announce: bool = true) -> void:
	ability_controller.assign_ability_to_slot(ability_id, slot_action, announce)

func get_ability_slot_action(ability_id: String) -> StringName:
	return ability_controller.get_ability_slot_action(ability_id)

func cycle_boomerang_ability_slot_action() -> void:
	ability_controller.cycle_boomerang_ability_slot_action()

func get_slot_label_for_action(slot_action: StringName) -> String:
	return ability_controller.get_slot_label_for_action(slot_action)

func set_boomerang_ability_slot_action(action_name: StringName) -> void:
	ability_controller.set_boomerang_ability_slot_action(action_name)

func get_boomerang_ability_slot_label() -> String:
	return ability_controller.get_boomerang_ability_slot_label()

func _get_camera_crosshair_target(max_distance: float = 120.0) -> Vector3:
	return camera_controller.get_camera_crosshair_target(max_distance)

func _get_camera_raw_aim_direction() -> Vector3:
	return camera_controller.get_raw_aim_direction()

func _get_camera_aim_direction() -> Vector3:
	return camera_controller.get_camera_aim_direction()

func _fire_active_weapon_primary() -> void:
	if not paper_popper_enabled or active_weapon_id != WEAPON_PAPER_POPPER or weapon_primary_cooldown > 0.0:
		return
	_spawn_player_projectile(1, 31.0, 0.24, "pistol_primary")

func _fire_active_weapon_secondary() -> void:
	if not paper_popper_enabled or active_weapon_id != WEAPON_PAPER_POPPER or weapon_secondary_cooldown > 0.0:
		return
	_spawn_player_projectile(2, 36.0, 0.48, "pistol_secondary")

func _spawn_player_projectile(damage: int, projectile_speed: float, cooldown: float, anim_kind: String) -> void:
	weapon_primary_cooldown = cooldown if anim_kind == "pistol_primary" else weapon_primary_cooldown
	weapon_secondary_cooldown = cooldown if anim_kind == "pistol_secondary" else weapon_secondary_cooldown
	attack_anim_kind = anim_kind
	attack_anim_timer = 0.16 if anim_kind == "pistol_primary" else 0.24
	muzzle_flash_timer = 0.06
	muzzle_flash.visible = true

	var crosshair_target: Vector3 = _get_camera_crosshair_target()
	var fire_direction: Vector3 = _get_camera_aim_direction()
	var flat_fire: Vector3 = Vector3(fire_direction.x, 0.0, fire_direction.z)
	if flat_fire.length_squared() > 0.001:
		facing_direction = flat_fire.normalized()
		yaw = atan2(-flat_fire.x, -flat_fire.z)

	var projectile = PLAYER_PROJECTILE_SCENE.instantiate()
	var scene_root: Node = get_tree().current_scene if get_tree().current_scene else get_tree().root
	scene_root.add_child(projectile)
	var muzzle_origin: Vector3 = muzzle_point.global_position if pistol_root.visible else global_position + Vector3.UP * 1.15
	var center_origin: Vector3 = global_position + Vector3.UP * 1.2 + fire_direction * 0.65
	projectile.global_position = muzzle_origin.lerp(center_origin, projectile_spawn_center_blend)
	if not (locked_target and is_instance_valid(locked_target)):
		var projectile_to_crosshair: Vector3 = crosshair_target - projectile.global_position
		if projectile_to_crosshair.length_squared() > 0.001:
			fire_direction = projectile_to_crosshair.normalized()
	projectile.setup(self, fire_direction, damage, projectile_speed)

func notify_boomerang_returned() -> void:
	boomerang_in_flight = false
	if wrench_catch_confirm_enabled:
		catch_confirm_ready = true
		catch_confirm_timer = wrench_catch_confirm_duration
		_show_status_notice("Catch Confirm ready", 1.4)
	else:
		catch_confirm_ready = false
		catch_confirm_timer = 0.0
	_refresh_weapon_visual_state()

func notify_hit_landed() -> void:
	_play_hit_confirm_feedback()

func take_damage(amount: int, source_position: Vector3 = Vector3.ZERO) -> void:
	if invincibility_timer > 0.0:
		return
	current_health = max(current_health - amount, 0)
	invincibility_timer = invincibility_time
	hit_confirm_timer = 0.0
	attack_anim_kind = "hurt"
	attack_anim_timer = max(attack_anim_timer, 0.22)
	_trigger_camera_shake(0.16, 0.16)
	if hurt_audio:
		hurt_audio.play()

	var knockback: Vector3 = global_position - source_position
	knockback.y = 0.0
	if knockback.length_squared() > 0.001:
		knockback = knockback.normalized()
		velocity.x = knockback.x * 5.0
		velocity.z = knockback.z * 5.0

	if current_health <= 0:
		_respawn_player()
	else:
		_refresh_hud()

func apply_external_knockback(source_position: Vector3, strength: float) -> void:
	var knockback: Vector3 = global_position - source_position
	knockback.y = 0.0
	if knockback.length_squared() <= 0.001:
		return
	knockback = knockback.normalized()
	velocity.x += knockback.x * strength
	velocity.z += knockback.z * strength

func add_xp(amount: int) -> void:
	xp_current += amount
	total_xp_earned += amount
	_refresh_hud()

func add_money(amount: int) -> void:
	money_current += amount
	_refresh_hud()

func get_money_total() -> int:
	return money_current

func get_money_drop_multiplier() -> float:
	return 1.0

func get_crate_shove_mass() -> float:
	return max(crate_shove_mass, 0.1)

func get_total_xp_earned() -> int:
	return total_xp_earned

func unlock_weapon(weapon_id: String, equip_now: bool = true) -> void:
	if weapon_id not in unlocked_weapon_ids:
		unlocked_weapon_ids.append(weapon_id)
	if active_weapon_id == "":
		active_weapon_id = weapon_id
	if equip_now:
		active_weapon_id = weapon_id
		weapon_stance_active = true
	_refresh_weapon_visual_state()
	_refresh_hud()

func has_weapon_unlocked(weapon_id: String) -> bool:
	return weapon_id in unlocked_weapon_ids

func toggle_weapon_mode() -> void:
	if not weapon_stance_toggle_enabled or active_weapon_id == "" or not has_weapon_unlocked(active_weapon_id):
		return
	weapon_stance_active = not weapon_stance_active
	_refresh_weapon_visual_state()
	_refresh_hud()

func get_debug_mechanic_rows() -> Array[Dictionary]:
	var rows: Array[Dictionary] = []
	for mechanic_id in DEBUG_MECHANIC_ORDER:
		rows.append({
			"id": mechanic_id,
			"label": _get_debug_mechanic_label(mechanic_id),
			"enabled": is_debug_mechanic_enabled(mechanic_id),
		})
	return rows

func is_debug_mechanic_enabled(mechanic_id: String) -> bool:
	match mechanic_id:
		"double_jump":
			return double_jump_enabled
		"high_jump":
			return high_jump_enabled
		"long_jump":
			return long_jump_enabled
		"feather_fall":
			return feather_fall_enabled
		"roll":
			return roll_enabled
		"air_dodge":
			return air_dodge_enabled
		"ground_pound":
			return ground_pound_enabled
		"wrench_throw":
			return wrench_throw_enabled
		"lock_on":
			return lock_on_enabled
		"paper_popper":
			return paper_popper_enabled
		"weapon_stance":
			return weapon_stance_toggle_enabled
		"wrench_mark":
			return wrench_combo_mark_enabled
		"enemy_spin_pull":
			return wrench_spin_pull_enabled
		"crate_pull":
			return wrench_crate_pull_enabled or wrench_crouch_crate_pull_enabled
		"catch_confirm":
			return wrench_catch_confirm_enabled
		"sky_resistance":
			return sky_resistance_enabled
		"camera_shake":
			return is_camera_shake_enabled()
		_:
			return false

func toggle_debug_mechanic(mechanic_id: String) -> void:
	match mechanic_id:
		"double_jump":
			double_jump_enabled = not double_jump_enabled
		"high_jump":
			high_jump_enabled = not high_jump_enabled
		"long_jump":
			long_jump_enabled = not long_jump_enabled
		"feather_fall":
			feather_fall_enabled = not feather_fall_enabled
		"roll":
			roll_enabled = not roll_enabled
			if not roll_enabled and attack_anim_kind == "roll":
				roll_timer = 0.0
		"air_dodge":
			air_dodge_enabled = not air_dodge_enabled
			if not air_dodge_enabled and attack_anim_kind == "air_dodge":
				roll_timer = 0.0
		"ground_pound":
			ground_pound_enabled = not ground_pound_enabled
			if not ground_pound_enabled:
				ground_pound_active = false
				ground_pound_pending_impact = false
		"wrench_throw":
			wrench_throw_enabled = not wrench_throw_enabled
		"lock_on":
			lock_on_enabled = not lock_on_enabled
			if not lock_on_enabled:
				locked_target = null
		"paper_popper":
			paper_popper_enabled = not paper_popper_enabled
			if not paper_popper_enabled and active_weapon_id == WEAPON_PAPER_POPPER:
				weapon_stance_active = false
		"weapon_stance":
			weapon_stance_toggle_enabled = not weapon_stance_toggle_enabled
			if not weapon_stance_toggle_enabled:
				weapon_stance_active = false
		"wrench_mark":
			wrench_combo_mark_enabled = not wrench_combo_mark_enabled
		"enemy_spin_pull":
			wrench_spin_pull_enabled = not wrench_spin_pull_enabled
		"crate_pull":
			var enabled: bool = not (wrench_crate_pull_enabled or wrench_crouch_crate_pull_enabled)
			wrench_crate_pull_enabled = enabled
			wrench_crouch_crate_pull_enabled = enabled
		"catch_confirm":
			wrench_catch_confirm_enabled = not wrench_catch_confirm_enabled
			if not wrench_catch_confirm_enabled:
				catch_confirm_ready = false
				catch_confirm_timer = 0.0
		"sky_resistance":
			sky_resistance_enabled = not sky_resistance_enabled
		"camera_shake":
			set_camera_shake_enabled(not is_camera_shake_enabled())
	_refresh_weapon_visual_state()
	_refresh_hud()

func _get_debug_mechanic_label(mechanic_id: String) -> String:
	match mechanic_id:
		"double_jump":
			return "Double Jump"
		"high_jump":
			return "High Jump"
		"long_jump":
			return "Long Jump"
		"feather_fall":
			return "Feather Fall"
		"roll":
			return "Roll"
		"air_dodge":
			return "Air Dodge"
		"ground_pound":
			return "Ground Pound"
		"wrench_throw":
			return "Wrench Throw"
		"lock_on":
			return "Lock-On"
		"paper_popper":
			return "Paper Popper"
		"weapon_stance":
			return "Weapon Stance"
		"wrench_mark":
			return "Enemy Mark on Hit"
		"enemy_spin_pull":
			return "Enemy Spin Pull"
		"crate_pull":
			return "Crate Pull"
		"catch_confirm":
			return "Catch Confirm"
		"sky_resistance":
			return "Sky Resistance"
		"camera_shake":
			return "Camera Shake"
		_:
			return mechanic_id.capitalize()

func cycle_camera_mode() -> void:
	camera_controller.cycle_camera_mode()
	_refresh_hud()

func set_camera_mode(mode_index: int) -> void:
	camera_controller.set_camera_mode(mode_index)
	_refresh_hud()

func get_camera_mode_index() -> int:
	return camera_controller.get_camera_mode_index()

func get_camera_mode_name() -> String:
	return camera_controller.get_camera_mode_name()

func get_active_weapon_label() -> String:
	if active_weapon_id == WEAPON_PAPER_POPPER:
		return "Paper Popper"
	return "Wrench"

func reset_run_progression() -> void:
	xp_current = 0
	money_current = 0
	total_xp_earned = 0
	unlocked_weapon_ids.clear()
	active_weapon_id = ""
	weapon_stance_active = false
	_reset_ability_assignments()
	unlock_ability(ABILITY_WRENCH_THROW, true)
	_refresh_weapon_visual_state()
	_refresh_hud()

func _respawn_player() -> void:
	global_position = spawn_position
	velocity = Vector3.ZERO
	current_health = max_health
	locked_target = null
	invincibility_timer = 1.0
	boomerang_in_flight = false
	_refresh_weapon_visual_state()
	_refresh_hud()

func _handle_fall_respawn() -> void:
	var health_loss: int = max(1, int(ceil(float(max_health) * fall_respawn_health_loss_ratio)))
	current_health = max(current_health - health_loss, 1)
	move_to_spawn(false, false)
	_trigger_camera_shake(0.2, 0.18)
	if hurt_audio:
		hurt_audio.play()
	_refresh_hud()

func _play_hit_confirm_feedback() -> void:
	hit_confirm_timer = 0.18
	if hit_confirm_audio:
		hit_confirm_audio.play()

func _trigger_camera_shake(duration: float, strength: float) -> void:
	camera_controller.trigger_shake(duration, strength)

func set_mouse_sensitivity(value: float) -> void:
	settings_controller.set_mouse_sensitivity(value)

func get_mouse_sensitivity() -> float:
	return settings_controller.get_mouse_sensitivity()

func set_invert_look_y(enabled: bool) -> void:
	settings_controller.set_invert_look_y(enabled)

func is_invert_look_y_enabled() -> bool:
	return settings_controller.is_invert_look_y_enabled()

func set_camera_fov_scale(value: float) -> void:
	settings_controller.set_camera_fov_scale(value)

func get_camera_fov_scale() -> float:
	return settings_controller.get_camera_fov_scale()

func set_camera_shake_enabled(enabled: bool) -> void:
	settings_controller.set_camera_shake_enabled(enabled)
	if not enabled:
		camera_controller.reset_transient_state()

func is_camera_shake_enabled() -> bool:
	return settings_controller.is_camera_shake_enabled()

func set_spawn_point(new_spawn: Vector3) -> void:
	spawn_position = new_spawn

func move_to_spawn(reset_health: bool = false, reset_xp: bool = false) -> void:
	global_position = spawn_position
	velocity = Vector3.ZERO
	locked_target = null
	boomerang_in_flight = false
	ground_pound_active = false
	ground_pound_pending_impact = false
	air_dodge_used = false
	air_attack_used = false
	jumps_used = 0
	attack_anim_kind = ""
	attack_anim_timer = 0.0
	roll_timer = 0.0
	movement_lock_timer = 0.0
	camera_controller.reset_transient_state()
	weapon_primary_cooldown = 0.0
	weapon_secondary_cooldown = 0.0
	muzzle_flash_timer = 0.0
	muzzle_flash.visible = false
	invincibility_timer = 0.75
	if reset_health:
		current_health = max_health
	if reset_xp:
		xp_current = 0
		money_current = 0
		total_xp_earned = 0
	catch_confirm_ready = false
	catch_confirm_timer = 0.0
	_refresh_weapon_visual_state()
	_refresh_hud()

func set_arena_bounds(mode: String, radius: float, square_half_extents: Vector2 = Vector2.ZERO) -> void:
	arena_shape_mode = mode
	arena_radius = radius
	if square_half_extents != Vector2.ZERO:
		arena_square_half_extents = square_half_extents

func _update_xp_orbs(delta: float) -> void:
	var attract_origin: Vector3 = global_position + Vector3.UP * 0.9
	for orb in get_tree().get_nodes_in_group("xp_orb"):
		if orb.has_method("attract_to"):
			orb.attract_to(attract_origin, delta, xp_collect_radius, xp_attract_radius, self)

func _update_money_pickups(_delta: float) -> void:
	var collect_origin: Vector3 = global_position + Vector3.UP * 0.85
	for pickup in get_tree().get_nodes_in_group("money_pickup"):
		if pickup.has_method("collect_to"):
			pickup.collect_to(collect_origin, money_collect_radius, self)

func _ensure_hud_refs() -> void:
	if status_label and player_health_bar and status_notice_label:
		return
	var hud_root: Node = get_tree().current_scene if get_tree().current_scene else get_parent()
	if hud_root == null:
		hud_root = get_tree().root
	if hud_root:
		if status_label == null:
			status_label = hud_root.get_node_or_null("CanvasLayer/StatusLabel") as Label
		if player_health_bar == null:
			player_health_bar = hud_root.get_node_or_null("CanvasLayer/PlayerHealthBar") as ProgressBar
		if status_notice_label == null:
			status_notice_label = hud_root.get_node_or_null("CanvasLayer/StatusNoticeLabel") as Label

func _refresh_hud() -> void:
	_ensure_hud_refs()
	if player_health_bar:
		player_health_bar.max_value = max_health
		player_health_bar.value = current_health
	if status_label:
		var weapon_text := "Weapon: %s" % get_active_weapon_label()
		if active_weapon_id != "":
			weapon_text += " [%s]" % ("Armed" if weapon_stance_active else "Melee")
		var catch_text: String = "Catch Confirm: OFF"
		if wrench_catch_confirm_enabled:
			catch_text = "Catch Confirm: READY" if catch_confirm_ready else "Catch Confirm: --"
		status_label.text = "Health: %d/%d\nXP: %d (Earned %d)\nMoney: %d\n%s\nAbilities: %s\n%s\nCamera: %s" % [current_health, max_health, xp_current, total_xp_earned, money_current, weapon_text, get_ability_loadout_text(), catch_text, get_camera_mode_name()]

func _show_status_notice(text: String, duration: float = 1.2) -> void:
	_ensure_hud_refs()
	status_notice_timer = duration
	if status_notice_label:
		status_notice_label.text = text

func get_ability_loadout_text() -> String:
	return ability_controller.get_loadout_text()

func _do_high_jump() -> void:
	velocity.y = high_jump_velocity
	jumps_used = 1
	attack_anim_kind = "high_jump"
	attack_anim_timer = 0.36
	movement_lock_timer = 0.08

func _do_long_jump() -> void:
	velocity.y = long_jump_vertical_speed
	velocity.x = facing_direction.x * long_jump_forward_speed
	velocity.z = facing_direction.z * long_jump_forward_speed
	jumps_used = 1
	attack_anim_kind = "long_jump"
	attack_anim_timer = 0.4
	movement_lock_timer = movement_lock_time

func _start_roll() -> void:
	if attack_cooldown > 0.0:
		return
	roll_timer = roll_time
	attack_cooldown = roll_time
	combo_step = 0
	combo_reset_timer = 0.0
	attack_anim_kind = "roll"
	attack_anim_timer = roll_time
	roll_direction = facing_direction.normalized()
	if roll_direction.length_squared() < 0.01:
		roll_direction = -Basis(Vector3.UP, camera_controller.get_camera_yaw()).z.normalized()

func _start_air_dodge(input_vec: Vector2) -> void:
	air_dodge_used = true
	roll_timer = air_dodge_time
	attack_cooldown = max(attack_cooldown, air_dodge_time)
	combo_step = 0
	combo_reset_timer = 0.0
	attack_anim_kind = "air_dodge"
	attack_anim_timer = air_dodge_time
	ground_pound_active = false
	air_attack_used = false

	var dodge_direction: Vector3 = Vector3.ZERO
	if locked_target:
		var to_target: Vector3 = locked_target.global_position - global_position
		to_target.y = 0.0
		if to_target.length_squared() > 0.001:
			var right: Vector3 = to_target.normalized().cross(Vector3.UP).normalized()
			dodge_direction = (right * input_vec.x + to_target.normalized() * -input_vec.y)
	else:
		var cam_basis: Basis = Basis(Vector3.UP, camera_controller.get_camera_yaw())
		var forward: Vector3 = -cam_basis.z
		var right: Vector3 = cam_basis.x
		forward.y = 0.0
		right.y = 0.0
		dodge_direction = right.normalized() * input_vec.x + forward.normalized() * -input_vec.y

	if dodge_direction.length_squared() < 0.001:
		dodge_direction = facing_direction
	roll_direction = dodge_direction.normalized()
	velocity.x = roll_direction.x * air_dodge_speed
	velocity.z = roll_direction.z * air_dodge_speed
	velocity.y = max(velocity.y, 1.0)

func _current_dodge_speed() -> float:
	if attack_anim_kind == "air_dodge":
		return air_dodge_speed
	return roll_speed

func _start_ground_pound() -> void:
	ground_pound_active = true
	ground_pound_pending_impact = true
	air_attack_used = true
	attack_anim_kind = "ground_pound"
	attack_anim_timer = 0.3
	movement_lock_timer = 0.18
	velocity.x *= 0.25
	velocity.z *= 0.25

func _resolve_ground_pound_impact() -> void:
	ground_pound_pending_impact = false
	ground_pound_active = false
	attack_anim_kind = "ground_pound_land"
	attack_anim_timer = 0.24
	_trigger_camera_shake(0.14, 0.12)
	_melee_hit(3.2 * _current_melee_radius_scale(), 360.0, max(1, int(round(2.0 * _current_melee_damage_scale()))))

func _find_lock_target() -> Node3D:
	if not lock_on_enabled:
		return null
	var best: Node3D = null
	var best_score: float = INF
	var origin: Vector3 = camera.global_position if camera and camera.is_inside_tree() else global_position + Vector3.UP * 1.1
	var aim_direction: Vector3 = (-camera.global_transform.basis.z).normalized() if camera and camera.is_inside_tree() else _get_camera_aim_direction()
	for node in get_tree().get_nodes_in_group("lock_target"):
		if not node is Node3D:
			continue
		var target: Node3D = node as Node3D
		var to_target: Vector3 = (target.global_position + Vector3.UP * 1.0) - origin
		var distance_sq: float = to_target.length_squared()
		if distance_sq > 400.0 or distance_sq < 0.01:
			continue
		var distance: float = sqrt(distance_sq)
		var target_dir: Vector3 = to_target / distance
		var look_dot: float = aim_direction.dot(target_dir)
		if look_dot <= 0.1:
			continue
		var look_angle: float = rad_to_deg(acos(clamp(look_dot, -1.0, 1.0)))
		var score: float = look_angle * 6.0 + distance * 0.35
		if score < best_score:
			best_score = score
			best = target
	return best

func _toggle_lock_on_target() -> void:
	if not lock_on_enabled:
		locked_target = null
		return
	if locked_target:
		locked_target = null
		return
	locked_target = _find_lock_target()

func toggle_lock_on_target() -> void:
	_toggle_lock_on_target()

func has_locked_target() -> bool:
	return locked_target != null and is_instance_valid(locked_target)

func get_locked_target() -> Node3D:
	return locked_target

func is_lock_on_enabled() -> bool:
	return lock_on_enabled

func _is_lock_on_toggle_event(event: InputEventKey) -> bool:
	if not lock_on_enabled:
		return false
	return event.is_action_pressed("lock_on") or event.physical_keycode == 4194308 or event.keycode == 4194308

func _apply_sky_resistance(delta: float) -> void:
	if not sky_resistance_enabled:
		return
	if global_position.y <= sky_resistance_start_y:
		return
	var overshoot: float = global_position.y - sky_resistance_start_y
	var overshoot_scale: float = 1.0 + overshoot / max(sky_resistance_band_height, 0.1)
	if velocity.y > 0.0:
		velocity.y = max(velocity.y - sky_resistance_upward_drag * overshoot_scale * delta, 0.0)
	velocity.y -= sky_resistance_downward_pull * overshoot_scale * delta

func _validate_lock_target() -> void:
	if locked_target == null:
		lock_indicator.visible = false
		return
	if not is_instance_valid(locked_target):
		locked_target = null
		lock_indicator.visible = false
		return
	if global_position.distance_squared_to(locked_target.global_position) > 484.0:
		locked_target = null
		lock_indicator.visible = false
		return
	lock_indicator.visible = true
	lock_indicator.global_position = locked_target.global_position + Vector3.UP * 2.0

func _update_visuals(delta: float) -> void:
	rotation.y = lerp_angle(rotation.y, yaw, delta * 12.0)

	var crouching: bool = is_on_floor() and Input.is_action_pressed("crouch") and roll_timer <= 0.0
	var target_scale_y: float = 1.0
	var target_scale_x: float = 1.0
	var target_visual_y: float = 1.0
	var target_tilt_x: float = 0.0
	var weapon_z_rot: float = 0.0
	var weapon_x_rot: float = 0.0
	var weapon_pos: Vector3 = Vector3(0.42, 0.15, 0.0)
	var crouch_indicator_scale: Vector3 = Vector3(0.55, 0.12, 0.55)
	var crouch_indicator_color: Color = Color(0.2, 0.9, 1.0, 0.0)

	if crouching:
		target_scale_y = 0.36
		target_scale_x = 1.28
		target_visual_y = 0.3
		target_tilt_x = deg_to_rad(-36.0)
		weapon_pos = Vector3(0.34, -0.18, 0.0)
		weapon_x_rot = deg_to_rad(55.0)
		weapon_z_rot = deg_to_rad(-20.0)
		crouch_indicator_scale = Vector3(1.0, 0.12, 1.0)
		crouch_indicator_color = Color(0.15, 1.0, 0.85, 0.95)

	if not is_on_floor():
		target_scale_y = max(target_scale_y, 1.08)

	if attack_anim_timer > 0.0:
		match attack_anim_kind:
			"slash_1":
				weapon_z_rot = lerp(deg_to_rad(-110.0), deg_to_rad(60.0), clamp(1.0 - attack_anim_timer / 0.2, 0.0, 1.0))
				weapon_pos.x = 0.62
			"slash_2":
				weapon_z_rot = lerp(deg_to_rad(120.0), deg_to_rad(-40.0), clamp(1.0 - attack_anim_timer / 0.22, 0.0, 1.0))
				weapon_pos.x = 0.62
			"spin":
				weapon_z_rot = Time.get_ticks_msec() * 0.02
				target_scale_x = 1.15
			"secondary_spin":
				weapon_z_rot = Time.get_ticks_msec() * 0.035
				target_scale_x = 1.24
				target_scale_y = 0.92
				target_tilt_x = deg_to_rad(-12.0)
			"crouch_spin":
				weapon_z_rot = Time.get_ticks_msec() * 0.042
				target_scale_x = 1.45
				target_scale_y = 0.28
				target_visual_y = 0.22
				target_tilt_x = deg_to_rad(-10.0)
				crouch_indicator_scale = Vector3(1.45, 0.12, 1.45)
				crouch_indicator_color = Color(0.95, 1.0, 0.2, 0.95)
			"boomerang":
				weapon_x_rot = deg_to_rad(-120.0 * clamp(1.0 - attack_anim_timer / 0.42, 0.0, 1.0))
				weapon_pos = Vector3(0.52, 0.42, -0.1)
			"throw_punch":
				target_scale_x = 1.08
				target_scale_y = 0.92
				target_tilt_x = deg_to_rad(-8.0)
				weapon_pos = Vector3(0.18, -0.04, 0.0)
				weapon_z_rot = deg_to_rad(22.0)
			"throw_spin":
				target_scale_x = 1.16
				target_scale_y = 0.88
				target_tilt_x = deg_to_rad(-14.0)
				weapon_pos = Vector3(0.0, -0.1, 0.0)
				weapon_z_rot = Time.get_ticks_msec() * 0.045
			"pistol_primary":
				weapon_pos = Vector3(0.34, 0.12, 0.0)
				weapon_x_rot = deg_to_rad(-18.0)
				weapon_z_rot = deg_to_rad(-6.0)
				target_tilt_x = deg_to_rad(-4.0)
			"pistol_secondary":
				weapon_pos = Vector3(0.38, 0.12, 0.0)
				weapon_x_rot = deg_to_rad(-30.0)
				weapon_z_rot = deg_to_rad(-10.0)
				target_tilt_x = deg_to_rad(-7.0)
				target_scale_x = 1.08
			"high_jump":
				target_scale_y = 1.3
				target_visual_y = 1.18
			"long_jump":
				target_scale_y = 0.78
				target_scale_x = 1.28
				target_visual_y = 0.74
				target_tilt_x = deg_to_rad(-18.0)
			"roll":
				target_scale_y = 0.3
				target_scale_x = 1.42
				target_visual_y = 0.36
				target_tilt_x = deg_to_rad(-75.0)
				weapon_pos = Vector3(0.12, -0.28, 0.0)
			"air_dodge":
				target_scale_y = 0.58
				target_scale_x = 1.38
				target_visual_y = 0.88
				target_tilt_x = deg_to_rad(-55.0)
				crouch_indicator_scale = Vector3(1.2, 0.12, 1.2)
				crouch_indicator_color = Color(1.0, 0.55, 0.9, 0.95)
			"ground_pound":
				target_scale_y = 1.36
				target_scale_x = 0.92
				target_tilt_x = deg_to_rad(-85.0)
				weapon_pos = Vector3(0.18, -0.24, 0.0)
			"ground_pound_land":
				target_scale_x = 1.36
				target_scale_y = 0.58
				target_visual_y = 0.72
				crouch_indicator_scale = Vector3(1.36, 0.12, 1.36)
				crouch_indicator_color = Color(1.0, 0.78, 0.25, 0.95)
			"hurt":
				target_scale_x = 1.18
				target_scale_y = 0.8
				target_tilt_x = deg_to_rad(12.0)
			"double_jump":
				target_scale_y = 1.28
				target_visual_y = 1.16
			"jump":
				target_scale_y = 1.12
				target_visual_y = 1.08

	visual_root.position.y = lerp(visual_root.position.y, target_visual_y, delta * 16.0)
	visual_root.scale = visual_root.scale.lerp(Vector3(target_scale_x, target_scale_y, 1.0), delta * 16.0)
	visual_root.rotation.x = lerp_angle(visual_root.rotation.x, target_tilt_x, delta * 16.0)

	var look_flat: Vector3 = camera.global_position - visual_root.global_position
	look_flat.y = 0.0
	if look_flat.length_squared() > 0.001:
		visual_root.look_at(visual_root.global_position + look_flat, Vector3.UP, true)
		visual_root.rotation.x = target_tilt_x

	weapon_root.position = weapon_root.position.lerp(weapon_pos, delta * 18.0)
	weapon_root.rotation.z = lerp_angle(weapon_root.rotation.z, weapon_z_rot, delta * 18.0)
	weapon_root.rotation.x = lerp_angle(weapon_root.rotation.x, weapon_x_rot, delta * 18.0)

	var box_shape: BoxShape3D = collision_shape.shape as BoxShape3D
	if box_shape:
		var shape_size: Vector3 = box_shape.size
		shape_size.y = lerp(shape_size.y, 0.9 if crouching else 1.8, delta * 18.0)
		box_shape.size = shape_size
		collision_shape.position.y = lerp(collision_shape.position.y, 0.45 if crouching else 0.9, delta * 18.0)

	crouch_indicator.visible = crouching or attack_anim_kind == "air_dodge" or catch_confirm_ready
	crouch_indicator.scale = crouch_indicator.scale.lerp(crouch_indicator_scale, delta * 16.0)
	var crouch_material: StandardMaterial3D = crouch_indicator.get_active_material(0) as StandardMaterial3D
	if crouch_material:
		crouch_material.albedo_color = crouch_material.albedo_color.lerp(crouch_indicator_color, delta * 18.0)

	var standing_preview_active: bool = attack_anim_kind == "secondary_spin" and attack_anim_timer > 0.0
	var crouch_preview_active: bool = attack_anim_kind == "crouch_spin" and attack_anim_timer > 0.0
	standing_spin_preview.visible = standing_preview_active
	crouch_spin_preview.visible = crouch_preview_active
	if standing_preview_active:
		standing_spin_preview.position.y = lerp(standing_spin_preview.position.y, 0.95, delta * 16.0)
		standing_spin_preview.scale = standing_spin_preview.scale.lerp(Vector3.ONE * standing_spin_hit_radius * 2.0 * (1.0 + 0.03 * sin(Time.get_ticks_msec() * 0.02)), delta * 12.0)
		var standing_mat: StandardMaterial3D = standing_spin_preview.get_active_material(0) as StandardMaterial3D
		if standing_mat:
			standing_mat.albedo_color = standing_mat.albedo_color.lerp(Color(0.45, 0.95, 1.0, 0.22), delta * 18.0)
	if crouch_preview_active:
		crouch_spin_preview.position.y = lerp(crouch_spin_preview.position.y, 0.18, delta * 16.0)
		crouch_spin_preview.scale = crouch_spin_preview.scale.lerp(Vector3(crouch_spin_hit_radius * 2.0 * (1.0 + 0.03 * sin(Time.get_ticks_msec() * 0.025)), max(crouch_spin_height_tolerance * 1.8, 0.12), crouch_spin_hit_radius * 2.0 * (1.0 + 0.03 * sin(Time.get_ticks_msec() * 0.025))), delta * 12.0)
		var crouch_preview_mat: StandardMaterial3D = crouch_spin_preview.get_active_material(0) as StandardMaterial3D
		if crouch_preview_mat:
			crouch_preview_mat.albedo_color = crouch_preview_mat.albedo_color.lerp(Color(1.0, 0.92, 0.35, 0.24), delta * 18.0)
	if not standing_preview_active:
		var standing_mat_off: StandardMaterial3D = standing_spin_preview.get_active_material(0) as StandardMaterial3D
		if standing_mat_off:
			standing_mat_off.albedo_color = standing_mat_off.albedo_color.lerp(Color(0.45, 0.95, 1.0, 0.0), delta * 18.0)
	if not crouch_preview_active:
		var crouch_preview_mat_off: StandardMaterial3D = crouch_spin_preview.get_active_material(0) as StandardMaterial3D
		if crouch_preview_mat_off:
			crouch_preview_mat_off.albedo_color = crouch_preview_mat_off.albedo_color.lerp(Color(1.0, 0.92, 0.35, 0.0), delta * 18.0)

	var state_indicator_visible: bool = catch_confirm_ready or hit_confirm_timer > 0.0 or boomerang_in_flight
	state_indicator.visible = state_indicator_visible
	state_indicator.position.y = lerp(state_indicator.position.y, 0.12 if catch_confirm_ready else 0.06, delta * 14.0)
	state_indicator.scale = state_indicator.scale.lerp(Vector3(1.7, 1.0, 1.7) if catch_confirm_ready else (Vector3(1.35, 1.0, 1.35) if boomerang_in_flight else Vector3(1.15, 1.0, 1.15)), delta * 12.0)
	state_indicator.rotation.y += delta * (3.2 if catch_confirm_ready else 2.0)
	var state_material: StandardMaterial3D = state_indicator.get_active_material(0) as StandardMaterial3D
	if state_material:
		var state_color: Color = Color(0.35, 0.95, 1.0, 0.0)
		if boomerang_in_flight:
			state_color = Color(0.55, 0.88, 1.0, 0.85)
		if hit_confirm_timer > 0.0:
			state_color = Color(1.0, 1.0, 0.52, 0.95)
		if catch_confirm_ready:
			state_color = Color(1.0, 0.9, 0.35, 0.95)
		state_material.albedo_color = state_material.albedo_color.lerp(state_color, delta * 18.0)

	var hit_color: Color = Color(1.0, 0.94, 0.94, 1.0)
	if crouching:
		hit_color = Color(0.6, 1.0, 0.88, 1.0)
	if attack_anim_kind == "air_dodge":
		hit_color = Color(1.0, 0.7, 0.92, 1.0)
	if catch_confirm_ready:
		hit_color = Color(1.0, 0.93, 0.58, 1.0)
	if invincibility_timer > 0.0 and int(Time.get_ticks_msec() / 80) % 2 == 0:
		hit_color = Color(1.0, 0.45, 0.55, 1.0)
	if hit_confirm_timer > 0.0:
		hit_color = Color(1.0, 1.0, 0.55, 1.0)
		wrench_mesh.scale = wrench_mesh.scale.lerp(Vector3(1.2, 1.2, 1.2), delta * 20.0)
		pistol_body.scale = pistol_body.scale.lerp(Vector3(1.05, 1.05, 1.05), delta * 20.0)
	else:
		wrench_mesh.scale = wrench_mesh.scale.lerp(Vector3.ONE, delta * 12.0)
		pistol_body.scale = pistol_body.scale.lerp(Vector3.ONE, delta * 12.0)

	paper_mesh.visible = camera_controller.get_camera_mode_index() != FIRST_PERSON_CAMERA_MODE
	var paper_material: StandardMaterial3D = paper_mesh.get_active_material(0) as StandardMaterial3D
	if paper_material:
		paper_material.albedo_color = paper_material.albedo_color.lerp(hit_color, delta * 16.0)
	for mesh in [wrench_handle, wrench_mesh, pistol_body, pistol_barrel]:
		var mesh_instance: MeshInstance3D = mesh as MeshInstance3D
		if mesh_instance == null:
			continue
		var material: StandardMaterial3D = mesh_instance.get_active_material(0) as StandardMaterial3D
		if material:
			material.albedo_color = material.albedo_color.lerp(hit_color, delta * 16.0)
	var flash_material: StandardMaterial3D = muzzle_flash.get_active_material(0) as StandardMaterial3D
	if flash_material:
		var target_flash: Color = Color(1, 0.95, 0.6, 0.95) if muzzle_flash.visible else Color(1, 0.95, 0.6, 0.0)
		flash_material.albedo_color = flash_material.albedo_color.lerp(target_flash, delta * 28.0)

func _update_camera(delta: float) -> void:
	camera_controller.tick(delta)

func _clamp_to_arena() -> void:
	if arena_shape_mode == "square":
		global_position.x = clamp(global_position.x, -arena_square_half_extents.x, arena_square_half_extents.x)
		global_position.z = clamp(global_position.z, -arena_square_half_extents.y, arena_square_half_extents.y)
		return
	var flat: Vector2 = Vector2(global_position.x, global_position.z)
	if flat.length() > arena_radius:
		flat = flat.normalized() * arena_radius
		global_position.x = flat.x
		global_position.z = flat.y

func _weapon_controls_active() -> bool:
	return active_weapon_id != "" and weapon_stance_active

func _current_melee_radius_scale() -> float:
	return 0.82 if _weapon_controls_active() else 1.0

func _current_melee_damage_scale() -> float:
	return 0.7 if _weapon_controls_active() else 1.0

func _refresh_weapon_visual_state() -> void:
	var showing_weapon: bool = _weapon_controls_active() and not boomerang_in_flight
	var showing_wrench: bool = not showing_weapon and not boomerang_in_flight
	wrench_handle.visible = showing_wrench
	wrench_mesh.visible = showing_wrench
	pistol_root.visible = showing_weapon
