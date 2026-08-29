class_name PlayerUpgrade
extends Resource

@export var name: String = ""
@export_multiline var description: String = ""
@export var icon: Texture2D
@export var tier: int = 1
@export var weight: float = 1.0
@export var tags: PackedStringArray = PackedStringArray()
@export var max_stacks: int = 1
@export var required_tags: PackedStringArray = PackedStringArray()
@export var blocked_tags: PackedStringArray = PackedStringArray()
@export_multiline var conditions: String = ""

func can_apply(context: Dictionary = {}, current_stacks: int = 0) -> bool:
    if current_stacks >= max_stacks:
        return false
    var context_tags: PackedStringArray = context.get("tags", PackedStringArray())
    for tag in required_tags:
        if not context_tags.has(tag):
            return false
    for tag in blocked_tags:
        if context_tags.has(tag):
            return false
    return true

func apply(_target: Node, _stack_count: int = 1) -> void:
    pass
