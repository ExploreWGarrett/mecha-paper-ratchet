extends Area3D

@export var speed: float = 26.0
@export var lifetime: float = 1.8
@export var damage: int = 1

var owner_player: Node = null
var direction: Vector3 = Vector3.FORWARD

func _ready() -> void:
    add_to_group("player_projectile")

func setup(player: Node, fire_direction: Vector3, projectile_damage: int, custom_speed: float = -1.0) -> void:
    owner_player = player
    damage = projectile_damage
    if custom_speed > 0.0:
        speed = custom_speed
    direction = fire_direction.normalized()
    if direction.length_squared() < 0.001:
        direction = Vector3.FORWARD

func _physics_process(delta: float) -> void:
    lifetime -= delta
    if lifetime <= 0.0:
        queue_free()
        return

    var move_vector: Vector3 = direction * speed * delta
    var query := PhysicsRayQueryParameters3D.create(global_position, global_position + move_vector)
    query.collide_with_areas = false
    query.collide_with_bodies = true
    query.hit_from_inside = true
    query.collision_mask = collision_mask
    query.exclude = [get_rid()]

    var hit: Dictionary = get_world_3d().direct_space_state.intersect_ray(query)
    if hit.is_empty():
        global_position += move_vector
    else:
        global_position = hit.position
        _handle_hit(hit.collider)
        return

    look_at(global_position + direction, Vector3.UP)

func _handle_hit(collider: Object) -> void:
    if collider and collider.has_method("take_damage"):
        if collider.is_in_group("enemy"):
            collider.take_damage(damage)
            if owner_player and owner_player.has_method("notify_hit_landed"):
                owner_player.notify_hit_landed()
        elif collider.is_in_group("destructible"):
            collider.take_damage(damage, true, global_position, 7.5)
            if owner_player and owner_player.has_method("notify_hit_landed"):
                owner_player.notify_hit_landed()
    queue_free()
