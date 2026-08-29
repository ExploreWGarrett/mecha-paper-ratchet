extends Area3D

@export var speed: float = 15.0
@export var damage: int = 1
@export var return_speed: float = 16.0
@export var max_return_speed: float = 23.0
@export var return_acceleration: float = 42.0
@export var return_catch_radius: float = 0.7
@export var world_slide_damping: float = 0.72
@export var outbound_timeout: float = 1.35
@export var return_timeout: float = 2.4
@export var blocked_return_arc_height: float = 4.8
@export var blocked_return_clearance_radius: float = 0.7

var owner_player: Node = null
var thrower: Node3D = null
var travel_direction: Vector3 = Vector3.FORWARD
var start_position: Vector3 = Vector3.ZERO
var target_position: Vector3 = Vector3.ZERO
var returning: bool = false
var hit_enemies: Array[Node] = []
var current_velocity: Vector3 = Vector3.ZERO
var outbound_timer: float = 0.0
var return_timer: float = 0.0
var return_waypoint_active: bool = false
var return_waypoint: Vector3 = Vector3.ZERO

func _ready() -> void:
    add_to_group("player_projectile")
    if current_velocity.length_squared() <= 0.001 and travel_direction.length_squared() > 0.001:
        current_velocity = travel_direction.normalized() * speed

func configure_launch(direction: Vector3, launch_speed: float = -1.0) -> void:
    if direction.length_squared() <= 0.001:
        return
    travel_direction = direction.normalized()
    current_velocity = travel_direction * (launch_speed if launch_speed > 0.0 else speed)

func _physics_process(delta: float) -> void:
    if returning:
        return_timer += delta
        if return_timer >= return_timeout:
            _recover_to_player(true)
            return
        _move_return(delta)
    else:
        outbound_timer += delta
        if outbound_timer >= outbound_timeout:
            _begin_return()
        _move_outbound(delta)

    rotate_x(delta * 18.0)
    rotate_y(delta * 9.0)
    rotate_z(delta * 22.0)

func _move_outbound(delta: float) -> void:
    var to_target: Vector3 = target_position - global_position
    if to_target.length() < 0.35:
        _begin_return()
        return

    var desired_velocity: Vector3 = to_target.normalized() * speed
    current_velocity = current_velocity.move_toward(desired_velocity, return_acceleration * delta)
    var move_vector: Vector3 = current_velocity * delta
    if move_vector.length_squared() <= 0.0:
        return
    _move_with_collision(move_vector, false)

func _move_return(delta: float) -> void:
    if thrower and is_instance_valid(thrower):
        var return_target: Vector3 = _get_return_target()
        var to_thrower: Vector3 = return_target - global_position
        if to_thrower.length() < return_catch_radius:
            if return_waypoint_active:
                return_waypoint_active = false
                return_waypoint = Vector3.ZERO
                return
            if owner_player and owner_player.has_method("notify_boomerang_returned"):
                owner_player.notify_boomerang_returned()
            queue_free()
            return
        var desired_velocity: Vector3 = to_thrower.normalized() * clamp(max(return_speed, current_velocity.length()), return_speed, max_return_speed)
        current_velocity = current_velocity.move_toward(desired_velocity, return_acceleration * delta)
        var move_vector: Vector3 = current_velocity * delta
        if move_vector.length_squared() > 0.0:
            _move_with_collision(move_vector, true)
        return

    if owner_player and owner_player.has_method("notify_boomerang_returned"):
        owner_player.notify_boomerang_returned()
    queue_free()

func _move_with_collision(move_vector: Vector3, allow_return_damage: bool) -> void:
    var query := PhysicsRayQueryParameters3D.create(global_position, global_position + move_vector)
    query.collide_with_areas = false
    query.collide_with_bodies = true
    query.collision_mask = collision_mask
    query.exclude = [get_rid()]
    if thrower is CollisionObject3D:
        query.exclude.append((thrower as CollisionObject3D).get_rid())

    var hit: Dictionary = get_world_3d().direct_space_state.intersect_ray(query)
    if hit.is_empty():
        global_position += move_vector
        return

    global_position = hit.position + hit.normal * 0.08
    _handle_hit(hit.collider, hit.normal, allow_return_damage)

func _handle_hit(collider: Object, hit_normal: Vector3 = Vector3.ZERO, allow_return_damage: bool = false) -> void:
    if collider and collider.is_in_group("enemy"):
        _damage_enemy(collider as Node)
        if not returning:
            _begin_return()
        return
    elif collider and collider.is_in_group("destructible"):
        _damage_destructible(collider as Node)
        if not returning:
            _begin_return()
        return
    if not returning:
        _begin_return()
        if current_velocity.length_squared() > 0.001:
            global_position += current_velocity.normalized() * 0.18
        return
    _slide_along_world(hit_normal)

func _damage_enemy(enemy: Node) -> void:
    if enemy == null or enemy in hit_enemies:
        return
    if not enemy.has_method("take_damage"):
        return
    enemy.take_damage(damage)
    if owner_player and owner_player.has_method("notify_hit_landed"):
        owner_player.notify_hit_landed()
    hit_enemies.append(enemy)

func _damage_destructible(target: Node) -> void:
    if target == null or not target.has_method("take_damage"):
        return
    target.take_damage(damage, true, global_position, 9.0)
    if owner_player and owner_player.has_method("notify_hit_landed"):
        owner_player.notify_hit_landed()

func _force_return_to_player() -> void:
    _recover_to_player(true)

func _begin_return() -> void:
    returning = true
    outbound_timer = 0.0
    return_timer = 0.0
    return_waypoint_active = false
    return_waypoint = Vector3.ZERO
    if thrower and is_instance_valid(thrower):
        var to_thrower: Vector3 = (thrower.global_position + Vector3.UP * 1.0) - global_position
        if to_thrower.length_squared() > 0.001:
            current_velocity = to_thrower.normalized() * return_speed

func _slide_along_world(hit_normal: Vector3) -> void:
    if hit_normal.length_squared() <= 0.001:
        current_velocity *= -0.25
        return
    current_velocity = current_velocity.slide(hit_normal) * world_slide_damping
    if current_velocity.length_squared() <= 0.0001 and thrower and is_instance_valid(thrower):
        var to_thrower: Vector3 = (thrower.global_position + Vector3.UP * 1.0) - global_position
        if to_thrower.length_squared() > 0.001:
            current_velocity = to_thrower.normalized() * (return_speed * 0.6)
    if returning:
        return_waypoint_active = false

func _get_return_target() -> Vector3:
    var player_target: Vector3 = thrower.global_position + Vector3.UP * 1.0
    if return_waypoint_active:
        if global_position.distance_to(return_waypoint) <= return_catch_radius * 1.5:
            return_waypoint_active = false
        elif not _is_world_blocking_line(global_position, return_waypoint):
            return return_waypoint
    if _is_world_blocking_line(global_position, player_target):
        return_waypoint = _build_arc_waypoint(player_target)
        return_waypoint_active = true
        return return_waypoint
    return_waypoint_active = false
    return_waypoint = Vector3.ZERO
    return player_target

func _build_arc_waypoint(player_target: Vector3) -> Vector3:
    var midpoint: Vector3 = global_position.lerp(player_target, 0.5)
    midpoint.y = max(global_position.y, player_target.y) + blocked_return_arc_height
    return midpoint

func _is_world_blocking_line(from_position: Vector3, to_position: Vector3) -> bool:
    if (to_position - from_position).length_squared() <= 0.001:
        return false
    var query := PhysicsRayQueryParameters3D.create(from_position, to_position)
    query.collide_with_areas = false
    query.collide_with_bodies = true
    query.collision_mask = collision_mask
    query.exclude = [get_rid()]
    if thrower is CollisionObject3D:
        query.exclude.append((thrower as CollisionObject3D).get_rid())
    var hit: Dictionary = get_world_3d().direct_space_state.intersect_ray(query)
    if hit.is_empty():
        return false
    var collider: Object = hit.collider
    if collider and (collider.is_in_group("enemy") or collider.is_in_group("destructible") or collider.is_in_group("player")):
        return false
    return true

func _recover_to_player(notify_player: bool) -> void:
    if notify_player and owner_player and owner_player.has_method("notify_boomerang_returned"):
        owner_player.notify_boomerang_returned()
    queue_free()
