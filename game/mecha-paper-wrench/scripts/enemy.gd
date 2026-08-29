extends CharacterBody3D

const ENEMY_PROJECTILE_SCENE := preload("res://scenes/EnemyProjectile.tscn")
const XP_ORB_SCENE := preload("res://scenes/XpOrb.tscn")

enum EnemyState {
    IDLE,
    CHASE,
    ATTACK,
    STAGGER,
}

@export var enemy_family: StringName = &"grunt"
@export var role_tags: PackedStringArray = PackedStringArray(["ground", "melee"])
@export var max_health: int = 8
@export var arena_radius: float = 11.0
@export var move_speed: float = 3.2
@export var patrol_range: float = 2.4
@export var patrol_speed: float = 1.6
@export var pursue_range: float = 9.5
@export var preferred_range: float = 0.0
@export var retreat_range: float = 0.0
@export var support_range: float = 0.0
@export var summon_limit: int = 0
@export var death_burst_range: float = 0.0
@export var melee_range: float = 2.2
@export var melee_damage: int = 1
@export var melee_cooldown: float = 1.3
@export var melee_windup_time: float = 0.18
@export var projectile_range: float = 8.5
@export var projectile_damage: int = 1
@export var projectile_cooldown: float = 1.7
@export var projectile_speed: float = 11.0
@export var stagger_time: float = 0.28
@export var xp_drop_amount: int = 30
@export var xp_orb_count: int = 3
@export var use_melee_attack: bool = true
@export var use_projectile_attack: bool = true
@export var use_aoe_attack: bool = false
@export var aoe_range: float = 4.8
@export var aoe_damage: int = 2
@export var aoe_cooldown: float = 3.8
@export var aoe_windup_time: float = 0.55
@export var is_flying: bool = false
@export var hover_height: float = 2.2
@export var hover_bob_amount: float = 0.18
@export var hover_bob_speed: float = 2.2

signal defeated

var arena_shape_mode: String = "circle"
var arena_square_half_extents: Vector2 = Vector2(11.0, 11.0)
var current_state: EnemyState = EnemyState.IDLE
var health: int = max_health
var start_position: Vector3
var hit_flash_timer: float = 0.0
var attack_cooldown: float = 0.0
var stagger_timer: float = 0.0
var attack_windup_timer: float = 0.0
var attack_windup_kind: String = ""
var time_passed: float = 0.0
var dead: bool = false
var attack_target: Node3D = null
var orbit_direction_sign: float = 1.0
var difficulty_name: String = "Normal"
var difficulty_scalar: float = 1.0
var difficulty_ready: bool = false
var wrench_mark_timer: float = 0.0

var base_move_speed: float = 0.0
var base_patrol_range: float = 0.0
var base_patrol_speed: float = 0.0
var base_pursue_range: float = 0.0
var base_preferred_range: float = 0.0
var base_retreat_range: float = 0.0
var base_melee_range: float = 0.0
var base_melee_damage: int = 0
var base_melee_cooldown: float = 0.0
var base_melee_windup_time: float = 0.0
var base_projectile_range: float = 0.0
var base_projectile_damage: int = 0
var base_projectile_cooldown: float = 0.0
var base_projectile_speed: float = 0.0
var base_stagger_time: float = 0.0
var base_aoe_range: float = 0.0
var base_aoe_damage: int = 0
var base_aoe_cooldown: float = 0.0
var base_aoe_windup_time: float = 0.0
var base_hover_height: float = 0.0
var base_hover_bob_amount: float = 0.0
var base_hover_bob_speed: float = 0.0

var current_move_speed: float = 0.0
var current_patrol_range: float = 0.0
var current_patrol_speed: float = 0.0
var current_pursue_range: float = 0.0
var current_preferred_range: float = 0.0
var current_retreat_range: float = 0.0
var current_melee_range: float = 0.0
var current_melee_damage: int = 0
var current_melee_cooldown: float = 0.0
var current_melee_windup_time: float = 0.0
var current_projectile_range: float = 0.0
var current_projectile_damage: int = 0
var current_projectile_cooldown: float = 0.0
var current_projectile_speed: float = 0.0
var current_stagger_time: float = 0.0
var current_aoe_range: float = 0.0
var current_aoe_damage: int = 0
var current_aoe_cooldown: float = 0.0
var current_aoe_windup_time: float = 0.0
var current_hover_height: float = 0.0
var current_hover_bob_amount: float = 0.0
var current_hover_bob_speed: float = 0.0
var current_projectile_burst: int = 1
var current_orbit_strength: float = 0.0
var current_retreat_bias: float = 0.0
var current_weave_bias: float = 0.0
var current_melee_lunge_speed: float = 0.0

@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var body_mesh: MeshInstance3D = $BodyMesh
@onready var core_mesh: MeshInstance3D = $CoreMesh
@onready var muzzle: Node3D = $Muzzle
@onready var health_fill: MeshInstance3D = $HealthBarRoot/HealthFill
@onready var mark_indicator: MeshInstance3D = get_node_or_null("MarkIndicator") as MeshInstance3D
@onready var aoe_indicator: MeshInstance3D = get_node_or_null("AoeIndicator") as MeshInstance3D

func _ready() -> void:
    add_to_group("enemy")
    add_to_group("lock_target")
    health = max_health
    start_position = global_position
    orbit_direction_sign = -1.0 if int(global_position.x * 10.0) % 2 == 0 else 1.0
    if aoe_indicator:
        aoe_indicator.visible = false
    if mark_indicator:
        mark_indicator.visible = false
    _cache_base_stats()
    configure_difficulty(difficulty_name, difficulty_scalar)
    _set_state(EnemyState.IDLE)

func _cache_base_stats() -> void:
    base_move_speed = move_speed
    base_patrol_range = patrol_range
    base_patrol_speed = patrol_speed
    base_pursue_range = pursue_range
    base_preferred_range = preferred_range
    base_retreat_range = retreat_range
    base_melee_range = melee_range
    base_melee_damage = melee_damage
    base_melee_cooldown = melee_cooldown
    base_melee_windup_time = melee_windup_time
    base_projectile_range = projectile_range
    base_projectile_damage = projectile_damage
    base_projectile_cooldown = projectile_cooldown
    base_projectile_speed = projectile_speed
    base_stagger_time = stagger_time
    base_aoe_range = aoe_range
    base_aoe_damage = aoe_damage
    base_aoe_cooldown = aoe_cooldown
    base_aoe_windup_time = aoe_windup_time
    base_hover_height = hover_height
    base_hover_bob_amount = hover_bob_amount
    base_hover_bob_speed = hover_bob_speed

func configure_difficulty(new_name: String, scalar: float) -> void:
    difficulty_name = new_name
    difficulty_scalar = clamp(scalar, 0.6, 1.8)
    if base_move_speed <= 0.0:
        _cache_base_stats()
    var tempo_scale: float = lerpf(0.88, 1.38, inverse_lerp(0.6, 1.8, difficulty_scalar))
    var pressure_scale: float = lerpf(0.82, 1.55, inverse_lerp(0.6, 1.8, difficulty_scalar))

    current_move_speed = base_move_speed * tempo_scale
    current_patrol_range = base_patrol_range * lerpf(0.9, 1.15, inverse_lerp(0.6, 1.8, difficulty_scalar))
    current_patrol_speed = base_patrol_speed * lerpf(0.9, 1.25, inverse_lerp(0.6, 1.8, difficulty_scalar))
    current_pursue_range = base_pursue_range * lerpf(0.95, 1.12, inverse_lerp(0.6, 1.8, difficulty_scalar))
    current_preferred_range = base_preferred_range
    current_retreat_range = base_retreat_range
    current_melee_range = base_melee_range * lerpf(0.96, 1.1, inverse_lerp(0.6, 1.8, difficulty_scalar))
    current_melee_damage = max(1, int(round(float(base_melee_damage) * lerpf(0.9, 1.55, inverse_lerp(0.6, 1.8, difficulty_scalar)))))
    current_melee_cooldown = max(0.42, base_melee_cooldown / pressure_scale)
    current_melee_windup_time = max(0.1, base_melee_windup_time / lerpf(0.95, 1.18, inverse_lerp(0.6, 1.8, difficulty_scalar)))
    current_projectile_range = base_projectile_range * lerpf(0.95, 1.15, inverse_lerp(0.6, 1.8, difficulty_scalar))
    current_projectile_damage = max(1, int(round(float(base_projectile_damage) * lerpf(0.9, 1.45, inverse_lerp(0.6, 1.8, difficulty_scalar)))))
    current_projectile_cooldown = max(0.45, base_projectile_cooldown / pressure_scale)
    current_projectile_speed = base_projectile_speed * lerpf(0.92, 1.18, inverse_lerp(0.6, 1.8, difficulty_scalar))
    current_stagger_time = max(0.06, base_stagger_time / lerpf(0.92, 1.28, inverse_lerp(0.6, 1.8, difficulty_scalar)))
    current_aoe_range = base_aoe_range * lerpf(0.94, 1.12, inverse_lerp(0.6, 1.8, difficulty_scalar))
    current_aoe_damage = max(1, int(round(float(base_aoe_damage) * lerpf(0.9, 1.45, inverse_lerp(0.6, 1.8, difficulty_scalar)))))
    current_aoe_cooldown = max(1.2, base_aoe_cooldown / lerpf(0.9, 1.22, inverse_lerp(0.6, 1.8, difficulty_scalar)))
    current_aoe_windup_time = max(0.18, base_aoe_windup_time / lerpf(0.95, 1.14, inverse_lerp(0.6, 1.8, difficulty_scalar)))
    current_hover_height = base_hover_height
    current_hover_bob_amount = base_hover_bob_amount * lerpf(0.9, 1.15, inverse_lerp(0.6, 1.8, difficulty_scalar))
    current_hover_bob_speed = base_hover_bob_speed * lerpf(0.95, 1.2, inverse_lerp(0.6, 1.8, difficulty_scalar))
    current_projectile_burst = 1
    current_orbit_strength = 0.0
    current_retreat_bias = 0.0
    current_weave_bias = 0.0
    current_melee_lunge_speed = current_move_speed * 2.4

    match String(enemy_family):
        "flyer":
            current_preferred_range = base_preferred_range + lerpf(-0.6, 1.25, inverse_lerp(0.6, 1.8, difficulty_scalar))
            current_retreat_range = max(3.4, base_retreat_range + lerpf(-0.2, 1.0, inverse_lerp(0.6, 1.8, difficulty_scalar)))
            current_projectile_burst = 1 + int(difficulty_scalar >= 1.15) + int(difficulty_scalar >= 1.55)
            current_orbit_strength = lerpf(0.35, 1.1, inverse_lerp(0.6, 1.8, difficulty_scalar))
            current_retreat_bias = lerpf(0.2, 0.9, inverse_lerp(0.6, 1.8, difficulty_scalar))
            current_weave_bias = lerpf(0.15, 0.65, inverse_lerp(0.6, 1.8, difficulty_scalar))
        "miniboss":
            current_projectile_burst = 1 + int(difficulty_scalar >= 1.35)
            current_orbit_strength = lerpf(0.08, 0.42, inverse_lerp(0.6, 1.8, difficulty_scalar))
            current_retreat_bias = lerpf(0.0, 0.25, inverse_lerp(0.6, 1.8, difficulty_scalar))
            current_weave_bias = lerpf(0.0, 0.35, inverse_lerp(0.6, 1.8, difficulty_scalar))
            current_melee_lunge_speed = current_move_speed * 3.1
        _:
            current_projectile_burst = 1 + int(difficulty_scalar >= 1.45)
            current_orbit_strength = lerpf(0.0, 0.65, inverse_lerp(0.6, 1.8, difficulty_scalar))
            current_retreat_bias = lerpf(0.0, 0.2, inverse_lerp(0.6, 1.8, difficulty_scalar))
            current_weave_bias = lerpf(0.0, 0.5, inverse_lerp(0.6, 1.8, difficulty_scalar))
            current_melee_lunge_speed = current_move_speed * 2.7

    difficulty_ready = true

func _physics_process(delta: float) -> void:
    time_passed += delta
    if wrench_mark_timer > 0.0:
        wrench_mark_timer = max(wrench_mark_timer - delta, 0.0)
    if attack_cooldown > 0.0:
        attack_cooldown -= delta
    if hit_flash_timer > 0.0:
        hit_flash_timer -= delta

    if attack_windup_timer > 0.0:
        _set_state(EnemyState.ATTACK)
        attack_windup_timer -= delta
        velocity.x = move_toward(velocity.x, 0.0, 22.0 * delta)
        velocity.z = move_toward(velocity.z, 0.0, 22.0 * delta)
        if attack_windup_timer <= 0.0:
            _resolve_windup_attack()
        _finish_motion(delta)
        return

    if stagger_timer > 0.0:
        _set_state(EnemyState.STAGGER)
        stagger_timer -= delta
        velocity.x = move_toward(velocity.x, 0.0, 20.0 * delta)
        velocity.z = move_toward(velocity.z, 0.0, 20.0 * delta)
        _finish_motion(delta)
        return

    var player: Node3D = _get_player()
    if player == null:
        _set_state(EnemyState.IDLE)
        _patrol(delta)
        _finish_motion(delta)
        return

    var to_player: Vector3 = player.global_position - global_position
    to_player.y = 0.0
    var distance: float = to_player.length()
    if to_player.length_squared() > 0.001:
        rotation.y = lerp_angle(rotation.y, atan2(-to_player.x, -to_player.z), delta * 8.0)

    if _try_attack(player, distance):
        _finish_motion(delta)
        return

    if distance <= current_pursue_range:
        _set_state(EnemyState.CHASE)
        _move_for_style(delta, to_player, distance)
    else:
        _set_state(EnemyState.IDLE)
        _patrol(delta)

    _finish_motion(delta)

func take_damage(amount: int) -> void:
    if dead:
        return
    health -= amount
    hit_flash_timer = 0.18
    stagger_timer = current_stagger_time
    attack_cooldown = max(attack_cooldown, 0.2)
    attack_windup_timer = 0.0
    attack_windup_kind = ""
    attack_target = null
    _set_state(EnemyState.STAGGER)
    if aoe_indicator:
        aoe_indicator.visible = false
    body_mesh.scale = Vector3(1.35, 0.62, 1.35) if not is_flying else Vector3(1.25, 0.7, 1.25)

    var player: Node3D = _get_player()
    if player:
        var knockback: Vector3 = global_position - player.global_position
        knockback.y = 0.0
        if knockback.length_squared() > 0.001:
            knockback = knockback.normalized()
            velocity.x = knockback.x * 4.0
            velocity.z = knockback.z * 4.0

    if health <= 0:
        _die()

func apply_external_knockback(source_position: Vector3, strength: float) -> void:
    if dead:
        return
    var knockback: Vector3 = global_position - source_position
    knockback.y = 0.0
    if knockback.length_squared() <= 0.001:
        return
    knockback = knockback.normalized()
    velocity.x += knockback.x * strength
    velocity.z += knockback.z * strength

func apply_wrench_mark(duration: float = 4.5) -> void:
    wrench_mark_timer = max(wrench_mark_timer, duration)

func has_wrench_mark() -> bool:
    return wrench_mark_timer > 0.0

func consume_wrench_mark() -> bool:
    if wrench_mark_timer <= 0.0:
        return false
    wrench_mark_timer = 0.0
    return true

func pull_toward(target_position: Vector3, strength: float = 4.2, yank_step: float = 0.0, min_distance: float = 1.05) -> void:
    if dead:
        return
    var pull: Vector3 = target_position - global_position
    pull.y = 0.0
    var distance: float = pull.length()
    if distance <= 0.001:
        return
    pull = pull.normalized()
    if yank_step > 0.0:
        var new_distance: float = max(min_distance, distance - yank_step)
        var new_position: Vector3 = target_position - pull * new_distance
        new_position.y = global_position.y
        global_position = new_position
    velocity.x = pull.x * strength
    velocity.z = pull.z * strength

func _try_attack(player: Node3D, distance: float) -> bool:
    if use_aoe_attack and distance <= current_aoe_range and attack_cooldown <= 0.0 and _should_prefer_aoe(distance):
        _set_state(EnemyState.ATTACK)
        _start_attack("aoe", player, current_aoe_cooldown, current_aoe_windup_time)
        return true
    if use_melee_attack and distance <= current_melee_range and attack_cooldown <= 0.0:
        _set_state(EnemyState.ATTACK)
        _start_attack("melee", player, current_melee_cooldown, current_melee_windup_time)
        return true
    if use_projectile_attack and distance <= current_projectile_range and attack_cooldown <= 0.0:
        _set_state(EnemyState.ATTACK)
        _do_projectile_attack(player)
        return true
    return false

func _should_prefer_aoe(distance: float) -> bool:
    if not use_aoe_attack:
        return false
    if String(enemy_family) != "miniboss":
        return true
    return distance <= current_aoe_range - 0.35 or difficulty_scalar >= 1.25

func _start_attack(kind: String, target: Node3D, cooldown: float, windup: float) -> void:
    attack_cooldown = cooldown
    attack_windup_timer = windup
    attack_windup_kind = kind
    attack_target = target
    match kind:
        "melee":
            body_mesh.scale = Vector3(0.8, 1.45, 0.8)
        "aoe":
            body_mesh.scale = Vector3(1.45, 0.82, 1.45)
            if aoe_indicator:
                aoe_indicator.visible = true
                aoe_indicator.scale = Vector3(current_aoe_range, 0.1, current_aoe_range)

func _resolve_windup_attack() -> void:
    body_mesh.scale = Vector3.ONE
    if aoe_indicator:
        aoe_indicator.visible = false
    match attack_windup_kind:
        "melee":
            _resolve_melee_attack()
        "aoe":
            _resolve_aoe_attack()
    attack_windup_kind = ""
    attack_target = null

func _resolve_melee_attack() -> void:
    if attack_target == null or not is_instance_valid(attack_target):
        return
    var to_player: Vector3 = attack_target.global_position - global_position
    to_player.y = 0.0
    if to_player.length_squared() > 0.001:
        var lunge_dir: Vector3 = to_player.normalized()
        velocity.x = lunge_dir.x * current_melee_lunge_speed
        velocity.z = lunge_dir.z * current_melee_lunge_speed
    if to_player.length() <= current_melee_range + 0.55 and attack_target.has_method("take_damage"):
        attack_target.take_damage(current_melee_damage, global_position)

func _resolve_aoe_attack() -> void:
    if attack_target == null or not is_instance_valid(attack_target):
        return
    var to_player: Vector3 = attack_target.global_position - global_position
    to_player.y = 0.0
    if to_player.length() <= current_aoe_range + 0.35 and attack_target.has_method("take_damage"):
        attack_target.take_damage(current_aoe_damage, global_position)

func _do_projectile_attack(player: Node3D) -> void:
    attack_cooldown = current_projectile_cooldown
    body_mesh.scale = Vector3(1.12, 0.85, 1.12)
    var burst_count: int = current_projectile_burst
    if String(enemy_family) == "miniboss" and difficulty_scalar >= 1.55:
        burst_count += 1
    for shot_index in range(burst_count):
        _spawn_projectile_shot(player, shot_index, burst_count)

func _spawn_projectile_shot(player: Node3D, shot_index: int, burst_count: int) -> void:
    var projectile = ENEMY_PROJECTILE_SCENE.instantiate()
    var scene_root: Node = get_tree().current_scene if get_tree().current_scene else get_tree().root
    scene_root.add_child(projectile)
    projectile.global_position = muzzle.global_position
    if projectile.has_method("setup"):
        var target_position: Vector3 = player.global_position + Vector3.UP * 1.0
        var spread_strength: float = 0.0
        if burst_count > 1:
            spread_strength = 0.35 if String(enemy_family) == "miniboss" else 0.22
            var offset_index: float = float(shot_index) - float(burst_count - 1) * 0.5
            var side: Vector3 = (player.global_position - global_position).normalized().cross(Vector3.UP).normalized()
            target_position += side * offset_index * spread_strength
        projectile.setup(self, target_position, current_projectile_damage, current_projectile_speed)

func _move_for_style(delta: float, to_player: Vector3, distance: float) -> void:
    if to_player.length_squared() < 0.001:
        return
    var dir_to_player: Vector3 = to_player.normalized()
    var tangent: Vector3 = dir_to_player.cross(Vector3.UP).normalized() * orbit_direction_sign

    if is_flying:
        var desired_dir: Vector3 = dir_to_player
        if distance < current_retreat_range:
            desired_dir = (-dir_to_player * (0.8 + current_retreat_bias) + tangent * current_weave_bias).normalized()
        elif distance > current_preferred_range:
            desired_dir = (dir_to_player + tangent * current_weave_bias * 0.35).normalized()
        else:
            desired_dir = (tangent * max(current_orbit_strength, 0.2) + dir_to_player * 0.1).normalized()
        velocity.x = move_toward(velocity.x, desired_dir.x * current_move_speed, 11.0 * delta)
        velocity.z = move_toward(velocity.z, desired_dir.z * current_move_speed, 11.0 * delta)
        return

    var desired_ground_dir: Vector3 = dir_to_player
    if distance > current_melee_range * 1.2 and distance < current_projectile_range * 0.92 and current_orbit_strength > 0.05:
        desired_ground_dir = (dir_to_player * (1.0 - current_retreat_bias * 0.35) + tangent * current_orbit_strength).normalized()
    elif distance < current_melee_range * 0.82 and current_retreat_bias > 0.0:
        desired_ground_dir = (-dir_to_player * current_retreat_bias + tangent * max(current_weave_bias, 0.1)).normalized()
    velocity.x = move_toward(velocity.x, desired_ground_dir.x * current_move_speed, 10.0 * delta)
    velocity.z = move_toward(velocity.z, desired_ground_dir.z * current_move_speed, 10.0 * delta)

func _patrol(delta: float) -> void:
    var patrol_offset: float = sin(time_passed * current_patrol_speed) * current_patrol_range
    var target_x: float = start_position.x + patrol_offset
    var dx: float = target_x - global_position.x
    velocity.x = move_toward(velocity.x, sign(dx) * min(abs(dx) * 2.0, current_move_speed * 0.65), 8.0 * delta)
    velocity.z = move_toward(velocity.z, 0.0, 8.0 * delta)

func _apply_hover(delta: float) -> void:
    if not is_flying:
        return
    var hover_target_y: float = start_position.y + current_hover_height + sin(time_passed * current_hover_bob_speed) * current_hover_bob_amount
    global_position.y = lerp(global_position.y, hover_target_y, delta * 8.0)

func _finish_motion(delta: float) -> void:
    _apply_hover(delta)
    move_and_slide()
    _clamp_to_arena()

func _process(delta: float) -> void:
    body_mesh.scale = body_mesh.scale.lerp(Vector3.ONE, delta * 10.0)
    if health_fill:
        var health_ratio: float = clamp(float(health) / float(max_health), 0.0, 1.0)
        health_fill.scale.x = lerp(health_fill.scale.x, health_ratio, delta * 18.0)
        health_fill.position.x = lerp(health_fill.position.x, -0.45 + health_ratio * 0.45, delta * 18.0)
    if aoe_indicator:
        aoe_indicator.visible = use_aoe_attack and attack_windup_kind == "aoe"
        aoe_indicator.rotation.y += delta * (0.9 + inverse_lerp(0.6, 1.8, difficulty_scalar) * 0.7)
    var mat: StandardMaterial3D = body_mesh.get_active_material(0) as StandardMaterial3D
    if mat:
        var target_color: Color = Color(1, 0.45098, 0.380392, 1)
        if is_flying:
            target_color = Color(0.42, 0.8, 1.0, 1)
        if wrench_mark_timer > 0.0:
            target_color = Color(1.0, 0.92, 0.42, 1)
        match current_state:
            EnemyState.STAGGER:
                target_color = Color(1, 0.85, 0.35, 1)
            EnemyState.ATTACK:
                if attack_windup_kind == "aoe":
                    target_color = Color(0.95, 0.2, 0.75, 1)
                elif attack_windup_kind == "melee":
                    target_color = Color(1, 0.75, 0.55, 1)
                elif use_projectile_attack:
                    target_color = Color(0.95, 0.62, 0.3, 1)
            EnemyState.CHASE:
                if is_flying:
                    target_color = Color(0.5, 0.88, 1.0, 1)
                elif difficulty_scalar >= 1.35:
                    target_color = Color(1.0, 0.42, 0.3, 1)
                else:
                    target_color = Color(1, 0.55, 0.42, 1)
        if hit_flash_timer > 0.0:
            target_color = Color(1, 1, 1, 1)
        mat.albedo_color = mat.albedo_color.lerp(target_color, delta * 18.0)
    if core_mesh:
        var core_material: StandardMaterial3D = core_mesh.get_active_material(0) as StandardMaterial3D
        if core_material:
            var target_core: Color = Color(1.0, 0.84, 0.3, 1)
            var target_emission: Color = Color(1.0, 0.7, 0.18, 1)
            var target_energy: float = 0.45
            if wrench_mark_timer > 0.0:
                target_core = Color(1.0, 0.96, 0.55, 1)
                target_emission = Color(1.0, 0.9, 0.35, 1)
                target_energy = 1.05
            core_material.albedo_color = core_material.albedo_color.lerp(target_core, delta * 16.0)
            core_material.emission = core_material.emission.lerp(target_emission, delta * 16.0)
            core_material.emission_energy_multiplier = lerp(core_material.emission_energy_multiplier, target_energy, delta * 12.0)
    if mark_indicator:
        mark_indicator.visible = wrench_mark_timer > 0.0
        mark_indicator.rotation.z += delta * 2.8
        mark_indicator.position.y = lerp(mark_indicator.position.y, 1.7 if wrench_mark_timer > 0.0 else 1.45, delta * 10.0)
        mark_indicator.scale = mark_indicator.scale.lerp(Vector3.ONE * (1.18 if wrench_mark_timer > 0.0 else 0.72), delta * 12.0)
        var mark_material: StandardMaterial3D = mark_indicator.get_active_material(0) as StandardMaterial3D
        if mark_material:
            var mark_color: Color = Color(1.0, 0.94, 0.45, 0.95) if wrench_mark_timer > 0.0 else Color(1.0, 0.94, 0.45, 0.0)
            mark_material.albedo_color = mark_material.albedo_color.lerp(mark_color, delta * 18.0)

func _get_player() -> Node3D:
    var players: Array = get_tree().get_nodes_in_group("player")
    if players.is_empty():
        return null
    return players[0] as Node3D

func _set_state(new_state: EnemyState) -> void:
    current_state = new_state

func get_state_name() -> String:
    match current_state:
        EnemyState.IDLE:
            return "Idle"
        EnemyState.CHASE:
            return "Chase"
        EnemyState.ATTACK:
            return "Attack"
        EnemyState.STAGGER:
            return "Stagger"
    return "Unknown"

func get_enemy_blueprint() -> Dictionary:
    return {
        "family": String(enemy_family),
        "role_tags": role_tags,
        "states": ["Idle", "Chase", "Attack", "Stagger"],
        "support_range": support_range,
        "summon_limit": summon_limit,
        "death_burst_range": death_burst_range,
        "difficulty": difficulty_name,
        "difficulty_scalar": difficulty_scalar,
        "projectile_burst": current_projectile_burst,
        "orbit_strength": current_orbit_strength,
    }

func get_crate_shove_mass() -> float:
    var mass_estimate: float = 0.9 + float(max_health) * 0.08
    if String(enemy_family) == "miniboss":
        mass_estimate += 1.0
    elif is_flying:
        mass_estimate -= 0.15
    return max(mass_estimate, 0.35)

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

func set_arena_bounds(mode: String, radius: float, square_half_extents: Vector2 = Vector2.ZERO) -> void:
    arena_shape_mode = mode
    arena_radius = radius
    if square_half_extents != Vector2.ZERO:
        arena_square_half_extents = square_half_extents

func _die() -> void:
    dead = true
    if aoe_indicator:
        aoe_indicator.visible = false
    _spawn_xp_drop()
    defeated.emit()
    queue_free()

func _spawn_xp_drop() -> void:
    var orb_count: int = max(xp_orb_count, 1)
    for i in range(orb_count):
        var orb = XP_ORB_SCENE.instantiate()
        var scene_root: Node = get_tree().current_scene if get_tree().current_scene else get_tree().root
        scene_root.add_child(orb)
        var angle: float = TAU * float(i) / float(orb_count)
        orb.global_position = global_position + Vector3(cos(angle), 0.35, sin(angle)) * 0.6
        orb.value = int(round(float(xp_drop_amount) / float(orb_count)))
        if orb.has_method("refresh_visual_tier"):
            orb.refresh_visual_tier()
