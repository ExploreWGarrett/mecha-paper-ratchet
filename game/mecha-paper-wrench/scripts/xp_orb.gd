extends Node3D

@export var value: int = 10
@export var bob_speed: float = 2.2
@export var bob_height: float = 0.14
@export var attract_speed: float = 8.5

var base_position: Vector3
var time_passed: float = 0.0

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D

func _ready() -> void:
    add_to_group("xp_orb")
    base_position = global_position
    refresh_visual_tier()

func _process(delta: float) -> void:
    time_passed += delta
    global_position.y = base_position.y + sin(time_passed * bob_speed) * bob_height
    rotate_y(delta * 3.5)

func attract_to(target: Vector3, delta: float, collect_radius: float, attract_radius: float, player: Node) -> void:
    var to_target: Vector3 = target - global_position
    var distance: float = to_target.length()
    if distance <= collect_radius:
        if player.has_method("add_xp"):
            player.add_xp(value)
        queue_free()
        return
    if distance <= attract_radius and distance > 0.001:
        global_position += to_target.normalized() * attract_speed * delta
        base_position = global_position

func refresh_visual_tier() -> void:
    var material: StandardMaterial3D = mesh_instance.get_active_material(0) as StandardMaterial3D
    if material == null:
        return
    if value >= 30:
        material.albedo_color = Color(0.9, 0.35, 1.0, 1.0)
        material.emission = Color(0.82, 0.24, 1.0, 1.0)
        material.emission_energy_multiplier = 0.85
    elif value >= 20:
        material.albedo_color = Color(0.28, 0.88, 1.0, 1.0)
        material.emission = Color(0.16, 0.74, 1.0, 1.0)
        material.emission_energy_multiplier = 0.72
    else:
        material.albedo_color = Color(0.35, 1.0, 0.55, 1.0)
        material.emission = Color(0.2, 1.0, 0.45, 1.0)
        material.emission_energy_multiplier = 0.6
