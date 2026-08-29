class_name MainLevelController extends Node

signal level_started(level_index: int, level_name: String)
signal level_cleared(level_index: int, level_data: Dictionary)

const GRUNT_SCENE := preload("res://scenes/Enemy.tscn")
const FLYER_SCENE := preload("res://scenes/EnemyFlyer.tscn")
const MINIBOSS_SCENE := preload("res://scenes/MiniBoss.tscn")
const CRATE_SCENE := preload("res://scenes/Crate.tscn")

const CRATE_STACK_PATTERNS := [
	[Vector3(0.0, 0.55, 0.0)],
	[Vector3(-0.55, 0.55, 0.0), Vector3(0.55, 0.55, 0.0)],
	[Vector3(0.0, 0.55, 0.0), Vector3(0.0, 1.65, 0.0)],
	[Vector3(-0.55, 0.55, 0.0), Vector3(0.55, 0.55, 0.0), Vector3(0.0, 1.65, 0.0)],
	[Vector3(0.0, 0.55, 0.0), Vector3(1.05, 0.55, 0.0), Vector3(1.05, 1.65, 0.0)],
	[Vector3(-0.55, 0.55, -0.55), Vector3(0.55, 0.55, -0.55), Vector3(-0.55, 0.55, 0.55), Vector3(0.55, 0.55, 0.55)],
	[Vector3(-0.55, 0.55, 0.0), Vector3(0.55, 0.55, 0.0), Vector3(-0.55, 1.65, 0.0)],
]

const LEVELS := [
	{
		"name": "Level 1 - Circle Arena", "shape": "circle", "radius": 11.5,
		"square_half_extents": Vector2(11.5, 11.5), "player_spawn": Vector3(0, 0, 5),
		"enemies": [{"scene": GRUNT_SCENE, "position": Vector3(0, 0, -2)}],
		"menu_title": "Level 1 Cleared", "menu_subtitle": "The square arena opens next."
	},
	{
		"name": "Level 2 - Square Arena", "shape": "square", "radius": 11.5,
		"square_half_extents": Vector2(11.2, 11.2), "player_spawn": Vector3(0, 0, 7),
		"enemies": [
			{"scene": GRUNT_SCENE, "position": Vector3(-4, 0, -4)},
			{"scene": FLYER_SCENE, "position": Vector3(4, 0, 3)}
		],
		"menu_title": "Level 2 Cleared", "menu_subtitle": "Flyers are in the rotation now. Back to the circle arena next."
	},
	{
		"name": "Level 3 - Circle Pressure", "shape": "circle", "radius": 11.5,
		"square_half_extents": Vector2(11.5, 11.5), "player_spawn": Vector3(0, 0, 5),
		"enemies": [
			{"scene": GRUNT_SCENE, "position": Vector3(-3.5, 0, -3)},
			{"scene": GRUNT_SCENE, "position": Vector3(3.25, 0, -1.5)},
			{"scene": FLYER_SCENE, "position": Vector3(0, 0, -6)}
		],
		"menu_title": "Level 3 Cleared", "menu_subtitle": "More crossfire ahead in the square arena."
	},
	{
		"name": "Level 4 - Square Swarm", "shape": "square", "radius": 11.5,
		"square_half_extents": Vector2(11.2, 11.2), "player_spawn": Vector3(0, 0, 7),
		"enemies": [
			{"scene": GRUNT_SCENE, "position": Vector3(-4.5, 0, -4.8)},
			{"scene": GRUNT_SCENE, "position": Vector3(4.5, 0, -2.8)},
			{"scene": FLYER_SCENE, "position": Vector3(-2.5, 0, 4.8)},
			{"scene": FLYER_SCENE, "position": Vector3(3.5, 0, 5.8)}
		],
		"menu_title": "Level 4 Cleared", "menu_subtitle": "The first miniboss waits in the circle arena."
	},
	{
		"name": "Level 5 - Grunt Miniboss", "shape": "circle", "radius": 11.5,
		"square_half_extents": Vector2(11.5, 11.5), "player_spawn": Vector3(0, 0, 6),
		"enemies": [
			{"scene": MINIBOSS_SCENE, "position": Vector3(0, 0, -3.5)},
			{"scene": FLYER_SCENE, "position": Vector3(4.8, 0, 3.8)}
		],
		"menu_title": "Miniboss Cleared", "menu_subtitle": "Prototype combat ladder complete for now."
	}
]

var root_scene: Node
var player: Node
var circle_arena: Node3D
var square_arena: Node3D
var circle_floor_shape: CollisionShape3D
var square_floor_shape: CollisionShape3D
var current_level_index: int = 0
var active_enemy_count: int = 0
var difficulty_name: String = "Normal"
var difficulty_scalar: float = 1.0

func configure(new_root: Node, new_player: Node, new_circle_arena: Node3D, new_square_arena: Node3D, new_circle_floor_shape: CollisionShape3D, new_square_floor_shape: CollisionShape3D) -> void:
	root_scene = new_root
	player = new_player
	circle_arena = new_circle_arena
	square_arena = new_square_arena
	circle_floor_shape = new_circle_floor_shape
	square_floor_shape = new_square_floor_shape

func set_difficulty(new_name: String, new_scalar: float) -> void:
	difficulty_name = new_name
	difficulty_scalar = new_scalar
	for enemy in get_tree().get_nodes_in_group("enemy"):
		if enemy.has_method("configure_difficulty"):
			enemy.configure_difficulty(difficulty_name, difficulty_scalar)

func get_current_level_index() -> int:
	return current_level_index

func get_level_count() -> int:
	return LEVELS.size()

func get_current_level_data() -> Dictionary:
	return LEVELS[current_level_index]

func get_level_data(level_index: int) -> Dictionary:
	return LEVELS[clamp(level_index, 0, LEVELS.size() - 1)]

func get_next_level_name() -> String:
	if current_level_index >= LEVELS.size() - 1:
		return ""
	return String(LEVELS[current_level_index + 1]["name"])

func load_level(level_index: int, reset_health: bool, reset_xp: bool) -> void:
	current_level_index = clamp(level_index, 0, LEVELS.size() - 1)
	var level: Dictionary = LEVELS[current_level_index]
	if reset_xp and player.has_method("reset_run_progression"):
		player.reset_run_progression()
	_clear_dynamic_nodes()
	_apply_level_geometry(level)
	player.set_spawn_point(level["player_spawn"])
	player.set_arena_bounds(level["shape"], level["radius"], level["square_half_extents"])
	player.move_to_spawn(reset_health, false)
	active_enemy_count = 0
	for enemy_entry in level["enemies"]:
		_spawn_enemy(enemy_entry, level)
	_spawn_level_crates(level)
	level_started.emit(current_level_index, String(level["name"]))

func _spawn_enemy(enemy_entry: Dictionary, level: Dictionary) -> void:
	var enemy = enemy_entry["scene"].instantiate()
	root_scene.add_child(enemy)
	enemy.global_position = enemy_entry["position"]
	enemy.set_arena_bounds(level["shape"], level["radius"], level["square_half_extents"])
	if enemy.has_method("configure_difficulty"):
		enemy.configure_difficulty(difficulty_name, difficulty_scalar)
	enemy.defeated.connect(_on_enemy_defeated)
	active_enemy_count += 1

func _apply_level_geometry(level: Dictionary) -> void:
	var is_square: bool = level["shape"] == "square"
	circle_arena.visible = not is_square
	square_arena.visible = is_square
	circle_floor_shape.disabled = is_square
	square_floor_shape.disabled = not is_square

func _clear_dynamic_nodes() -> void:
	for group_name in ["enemy", "xp_orb", "money_pickup", "enemy_projectile", "player_projectile", "crate"]:
		for node in get_tree().get_nodes_in_group(group_name):
			node.queue_free()
	for child in root_scene.get_children():
		if child == player or child == root_scene.get_node_or_null("WorldEnvironment") or child == root_scene.get_node_or_null("DirectionalLight3D") or child == root_scene.get_node_or_null("LevelGeometry") or child == root_scene.get_node_or_null("CanvasLayer") or child == self:
			continue
		if child.name in ["Boomerang", "EnemyProjectile", "XpOrb", "MoneyPickup", "Enemy", "EnemyFlyer", "MiniBoss", "PaperPopperProjectile", "Crate"]:
			child.queue_free()

func _spawn_level_crates(level: Dictionary) -> void:
	var level_number: int = current_level_index + 1
	var cluster_count: int = randi_range(1 + int(level_number / 2), 2 + int(level_number / 2))
	for _cluster_index in range(cluster_count):
		var pattern: Array = CRATE_STACK_PATTERNS[randi() % CRATE_STACK_PATTERNS.size()]
		var origin: Vector3 = _find_crate_cluster_origin(level, pattern)
		for offset in pattern:
			var crate = CRATE_SCENE.instantiate()
			root_scene.add_child(crate)
			crate.global_position = origin + offset
			crate.rotation.y = deg_to_rad(float([0, 90, 180, 270][randi() % 4]))
			var base_value: int = 5 + level_number * 3 + randi_range(0, 4)
			var scaled_value: int = int(round(float(base_value) * player.get_money_drop_multiplier()))
			crate.configure_for_level(level_number, scaled_value)

func _find_crate_cluster_origin(level: Dictionary, pattern: Array) -> Vector3:
	var footprint: float = _get_crate_pattern_footprint(pattern)
	for _attempt in range(24):
		var candidate: Vector3 = _random_point_in_level(level, 2.2 + footprint)
		if _is_crate_origin_valid(candidate, level, footprint):
			return candidate
	return level["player_spawn"] + Vector3(footprint + 3.5, 0.0, -footprint - 3.5)

func _get_crate_pattern_footprint(pattern: Array) -> float:
	var furthest: float = 0.8
	for offset in pattern:
		var flat: Vector2 = Vector2((offset as Vector3).x, (offset as Vector3).z)
		furthest = max(furthest, flat.length() + 0.7)
	return furthest

func _random_point_in_level(level: Dictionary, margin: float) -> Vector3:
	if level["shape"] == "square":
		var extents: Vector2 = level["square_half_extents"]
		return Vector3(randf_range(-extents.x + margin, extents.x - margin), 0.0, randf_range(-extents.y + margin, extents.y - margin))
	var angle: float = randf() * TAU
	var radius: float = sqrt(randf()) * max(level["radius"] - margin, 1.0)
	return Vector3(cos(angle) * radius, 0.0, sin(angle) * radius)

func _is_crate_origin_valid(origin: Vector3, level: Dictionary, footprint: float) -> bool:
	if origin.distance_to(level["player_spawn"]) < 4.4 + footprint:
		return false
	for enemy_entry in level["enemies"]:
		if origin.distance_to(enemy_entry["position"]) < 3.8 + footprint:
			return false
	return true

func _on_enemy_defeated() -> void:
	active_enemy_count = max(active_enemy_count - 1, 0)
	if active_enemy_count == 0:
		_collect_remaining_xp()
		level_cleared.emit(current_level_index, get_current_level_data())

func _collect_remaining_xp() -> void:
	for orb in get_tree().get_nodes_in_group("xp_orb"):
		player.add_xp(orb.value)
		orb.queue_free()
