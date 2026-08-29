extends Node3D

@export var value: int = 6
@export var bob_speed: float = 2.0
@export var bob_height: float = 0.1

var base_position: Vector3
var time_passed: float = 0.0

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D

func _ready() -> void:
    add_to_group("money_pickup")
    base_position = global_position
    refresh_visual_tier()

func _process(delta: float) -> void:
    time_passed += delta
    global_position.y = base_position.y + sin(time_passed * bob_speed) * bob_height
    rotate_y(delta * 2.8)

func collect_to(target: Vector3, collect_radius: float, player: Node) -> void:
    if global_position.distance_to(target) > collect_radius:
        return
    if player and player.has_method("add_money"):
        player.add_money(value)
    queue_free()

func refresh_visual_tier() -> void:
    var material: StandardMaterial3D = mesh_instance.get_active_material(0) as StandardMaterial3D
    if material == null:
        return
    if value >= 24:
        material.albedo_color = Color(0.95, 0.78, 0.22, 1.0)
        material.emission = Color(0.95, 0.72, 0.15, 1.0)
        material.emission_energy_multiplier = 0.8
    elif value >= 14:
        material.albedo_color = Color(0.98, 0.65, 0.18, 1.0)
        material.emission = Color(0.95, 0.48, 0.12, 1.0)
        material.emission_energy_multiplier = 0.66
    else:
        material.albedo_color = Color(1.0, 0.9, 0.35, 1.0)
        material.emission = Color(0.9, 0.76, 0.22, 1.0)
        material.emission_energy_multiplier = 0.52
