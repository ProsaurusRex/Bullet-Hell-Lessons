class_name TurretEnemy
extends Node2D

@export var bullet_manager: Node2D
@export var target: Node2D
@export var destination: Vector2
@export var targetting = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for t in get_children():
		if t is Turret:
			t.bullet_manager = bullet_manager
			if targetting:
				t.target = target
			t.connect("tree_exiting", turret_destroyed)


func _physics_process(delta: float) -> void:
	if destination:
		position = lerp(position, destination, 0.2)


func turret_destroyed():
	queue_free()
