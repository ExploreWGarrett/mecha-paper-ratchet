extends Area3D

@export var speed: float = 11.0
@export var lifetime: float = 3.0

var damage: int = 1
var direction: Vector3 = Vector3.FORWARD
var owner_enemy: Node3D = null

func _ready() -> void:
    add_to_group("enemy_projectile")

func setup(enemy: Node3D, target_position: Vector3, projectile_damage: int, custom_speed: float = -1.0) -> void:
    owner_enemy = enemy
    damage = projectile_damage
    if custom_speed > 0.0:
        speed = custom_speed
    direction = (target_position - global_position).normalized()
    if direction.length_squared() < 0.001:
        direction = Vector3.FORWARD

func _physics_process(delta: float) -> void:
    lifetime -= delta
    if lifetime <= 0.0:
        queue_free()
        return

    global_position += direction * speed * delta
    rotate_y(delta * 10.0)
    rotate_z(delta * 17.0)

    for node in get_tree().get_nodes_in_group("player"):
        if not node.has_method("take_damage"):
            continue
        if global_position.distance_to(node.global_position + Vector3.UP * 1.0) <= 1.0:
            node.take_damage(damage, global_position)
            queue_free()
            return
