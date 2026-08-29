extends RigidBody3D

const MONEY_PICKUP_SCENE := preload("res://scenes/MoneyPickup.tscn")

@export var max_health: int = 3
@export var impact_damage_speed: float = 8.0
@export var heavy_impact_speed: float = 12.5
@export var fall_damage_height: float = 2.8
@export var break_scatter_radius: float = 0.6
@export var contact_damage_cooldown: float = 0.22
@export var money_drop_total: int = 12
@export var loot_tags: PackedStringArray = PackedStringArray(["money"])
@export var future_drop_roll_chance: float = 0.0
@export var shove_speed_threshold: float = 1.35
@export var shove_impulse_scale: float = 1.3
@export var shove_neighbor_radius: float = 1.65
@export var shove_neighbor_resistance: float = 0.2
@export var shove_stack_resistance: float = 0.35
@export var crate_collision_enemy_damage_scale: float = 0.22
@export var crate_collision_player_knockback_scale: float = 0.18

var current_health: int = max_health
var last_contact_damage_time: float = -10.0
var spawned_by_level: int = 1
var peak_height_since_grounded: float = 0.0

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D

func _ready() -> void:
    add_to_group("destructible")
    add_to_group("crate")
    body_entered.connect(_on_body_entered)
    current_health = max_health
    sleeping = true
    can_sleep = true
    contact_monitor = true
    max_contacts_reported = 8
    peak_height_since_grounded = global_position.y
    _refresh_visual_state()

func _physics_process(_delta: float) -> void:
    if linear_velocity.y > 0.2 or not sleeping:
        peak_height_since_grounded = max(peak_height_since_grounded, global_position.y)

func configure_for_level(level_index: int, total_money_value: int) -> void:
    spawned_by_level = level_index
    money_drop_total = max(total_money_value, 1)
    max_health = 3 + int(level_index >= 4)
    current_health = max_health
    peak_height_since_grounded = global_position.y
    _refresh_visual_state()

func take_damage(amount: int, caused_by_player: bool = false, source_position: Vector3 = Vector3.ZERO, impulse_strength: float = 0.0) -> void:
    current_health = max(current_health - amount, 0)
    if caused_by_player and impulse_strength > 0.0:
        var away: Vector3 = global_position - source_position
        away.y = max(away.y, 0.12)
        if away.length_squared() < 0.001:
            away = Vector3.UP
        apply_central_impulse(away.normalized() * impulse_strength)
        apply_torque_impulse(Vector3(randf_range(-0.8, 0.8), randf_range(-0.4, 0.4), randf_range(-0.8, 0.8)) * impulse_strength * 0.14)
        sleeping = false
    _refresh_visual_state()
    if current_health <= 0:
        _destroy(caused_by_player)

func _apply_fall_damage() -> void:
    var fall_distance: float = peak_height_since_grounded - global_position.y
    peak_height_since_grounded = global_position.y
    if fall_distance < fall_damage_height:
        return
    var bonus_damage: int = 1 + int(fall_distance >= fall_damage_height + 1.6)
    take_damage(bonus_damage, false)

func _destroy(_caused_by_player: bool) -> void:
    _drop_money()
    queue_free()

func _drop_money() -> void:
    if money_drop_total <= 0:
        return
    var scene_root: Node = get_tree().current_scene if get_tree().current_scene else get_tree().root
    var drop_count: int = clamp(int(round(money_drop_total / 8.0)), 1, 4)
    var remaining_value: int = money_drop_total
    var floor_anchor: Vector3 = _get_floor_anchor_position()
    for index in range(drop_count):
        var pickup = MONEY_PICKUP_SCENE.instantiate()
        scene_root.add_child(pickup)
        var value: int = remaining_value if index == drop_count - 1 else max(1, int(round(float(money_drop_total) / float(drop_count) + randi_range(-1, 2))))
        value = min(value, remaining_value)
        remaining_value -= value
        pickup.value = value
        pickup.global_position = floor_anchor + Vector3(randf_range(-break_scatter_radius, break_scatter_radius), 0.24 + randf_range(0.0, 0.18), randf_range(-break_scatter_radius, break_scatter_radius))
        if pickup.has_method("refresh_visual_tier"):
            pickup.refresh_visual_tier()

func _get_floor_anchor_position() -> Vector3:
    var start: Vector3 = global_position + Vector3.UP * 0.8
    var query := PhysicsRayQueryParameters3D.create(start, start + Vector3.DOWN * 20.0)
    query.collide_with_areas = false
    query.collide_with_bodies = true
    query.exclude = [get_rid()]
    var hit: Dictionary = get_world_3d().direct_space_state.intersect_ray(query)
    if hit.is_empty():
        return global_position
    return hit.position + Vector3.UP * 0.08

func _on_body_entered(body: Node) -> void:
    if body == null:
        return
    _apply_body_shove(body)
    var now: float = Time.get_ticks_msec() / 1000.0
    if now - last_contact_damage_time < contact_damage_cooldown:
        return
    var impact_speed: float = _get_impact_speed_against(body)
    if impact_speed < impact_damage_speed:
        peak_height_since_grounded = global_position.y
        return
    last_contact_damage_time = now
    var impact_damage: int = 2 if impact_speed >= heavy_impact_speed else 1
    var survives_impact: bool = current_health - impact_damage > 0
    _apply_impact_to_other(body, impact_speed, impact_damage, survives_impact)
    take_damage(impact_damage, false)
    _apply_fall_damage()

func _get_impact_speed_against(body: Node) -> float:
    var impact_speed: float = linear_velocity.length()
    if body is RigidBody3D:
        impact_speed = max(impact_speed, linear_velocity.length() + (body as RigidBody3D).linear_velocity.length() * 0.3)
    elif body is CharacterBody3D:
        impact_speed = max(impact_speed, linear_velocity.length() + (body as CharacterBody3D).velocity.length() * 0.25)
    return impact_speed

func _apply_impact_to_other(body: Node, impact_speed: float, impact_damage: int, survives_impact: bool) -> void:
    var speed_factor: float = clamp(inverse_lerp(impact_damage_speed, heavy_impact_speed + 6.0, impact_speed), 0.0, 1.0)
    if body.is_in_group("crate"):
        if body.has_method("take_damage"):
            body.take_damage(max(impact_damage, 1), false, global_position, max(impact_speed * 0.32, 0.1))
        return
    if body.is_in_group("enemy"):
        if body.has_method("take_damage"):
            var enemy_damage: int = max(1, int(round(float(impact_speed) * crate_collision_enemy_damage_scale)))
            body.take_damage(enemy_damage)
        if body.has_method("apply_external_knockback"):
            body.apply_external_knockback(global_position, 2.2 + speed_factor * 3.2)
        return
    if body.is_in_group("player") and survives_impact and body.has_method("apply_external_knockback"):
        body.apply_external_knockback(global_position, 1.2 + impact_speed * crate_collision_player_knockback_scale)

func _apply_body_shove(body: Node) -> void:
    if body == null:
        return
    var move_velocity: Vector3 = Vector3.ZERO
    if body is CharacterBody3D:
        move_velocity = (body as CharacterBody3D).velocity
    elif body is RigidBody3D:
        move_velocity = (body as RigidBody3D).linear_velocity
    move_velocity.y = 0.0
    var move_speed: float = move_velocity.length()
    if move_speed < shove_speed_threshold:
        return

    var shove_direction: Vector3 = move_velocity.normalized()
    if shove_direction.length_squared() <= 0.001:
        shove_direction = global_position - body.global_position
        shove_direction.y = 0.0
        if shove_direction.length_squared() <= 0.001:
            return
        shove_direction = shove_direction.normalized()

    var mover_mass: float = 1.0
    if body.has_method("get_crate_shove_mass"):
        mover_mass = max(float(body.call("get_crate_shove_mass")), 0.1)
    elif body.is_in_group("enemy"):
        mover_mass = 1.1
    elif body.is_in_group("player"):
        mover_mass = 1.25

    var resistance: float = _get_shove_resistance_factor()
    var impulse_strength: float = (move_speed - shove_speed_threshold) * shove_impulse_scale * mover_mass / resistance
    if impulse_strength <= 0.01:
        return
    linear_velocity += shove_direction * (impulse_strength * 0.22)
    apply_central_impulse((shove_direction + Vector3.UP * 0.05).normalized() * impulse_strength)
    apply_torque_impulse(Vector3(randf_range(-0.24, 0.24), randf_range(-0.1, 0.1), randf_range(-0.24, 0.24)) * impulse_strength)
    sleeping = false

func pull_toward(target_position: Vector3, strength: float = 3.6, yank_step: float = 0.0, min_distance: float = 1.0) -> void:
    var toward: Vector3 = target_position - global_position
    toward.y = 0.0
    var distance: float = toward.length()
    if distance < 0.05:
        return
    var direction: Vector3 = toward / distance
    var goal_distance: float = max(min_distance, 0.65)
    if yank_step > 0.0 and distance > goal_distance:
        var next_distance: float = max(distance - yank_step, goal_distance)
        global_position = Vector3(target_position.x, global_position.y, target_position.z) - direction * next_distance
    linear_velocity += direction * strength
    apply_central_impulse((direction + Vector3.UP * 0.04).normalized() * max(strength * 0.45, 0.1))
    sleeping = false

func _get_shove_resistance_factor() -> float:
    var nearby_crates: int = 0
    var stacked_support: int = 0
    var shape := SphereShape3D.new()
    shape.radius = shove_neighbor_radius
    var params := PhysicsShapeQueryParameters3D.new()
    params.shape = shape
    params.transform = Transform3D(Basis.IDENTITY, global_position)
    params.collide_with_areas = false
    params.collide_with_bodies = true
    params.collision_mask = collision_layer | collision_mask
    params.exclude = [get_rid()]
    for hit in get_world_3d().direct_space_state.intersect_shape(params, 16):
        var collider: Object = hit.get("collider")
        if collider == null or collider == self or not collider.is_in_group("crate"):
            continue
        nearby_crates += 1
        if abs((collider as Node3D).global_position.y - global_position.y) > 0.45:
            stacked_support += 1
    return 1.0 + nearby_crates * shove_neighbor_resistance + stacked_support * shove_stack_resistance

func _refresh_visual_state() -> void:
    var material: StandardMaterial3D = mesh_instance.get_active_material(0) as StandardMaterial3D
    if material == null:
        return
    var ratio: float = float(current_health) / float(max(max_health, 1))
    material.albedo_color = Color(0.64, 0.42, 0.18, 1.0).lerp(Color(0.33, 0.15, 0.08, 1.0), 1.0 - ratio)
    material.emission = Color(0.18, 0.08, 0.02, 1.0)
    material.emission_energy_multiplier = 0.12 + (1.0 - ratio) * 0.18
