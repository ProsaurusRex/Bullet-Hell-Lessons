class_name TurretEnemy
extends Node2D

@export var bullet_manager: Node2D
@export var target: Node2D
@export var destination_array: Array[Vector2]
@export var targetting = false

var speed = 100
var destination: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for t in get_children():
		if t is Turret:
			t.bullet_manager = bullet_manager
			if targetting:
				t.target = target
			t.connect("tree_exiting", turret_destroyed)


func _physics_process(delta: float) -> void:
	if not destination_array.is_empty():
		if position.distance_squared_to(destination_array[destination]) > 1:
			position.x = move_toward(position.x, destination_array[destination].x, speed * delta)
			position.y = move_toward(position.y, destination_array[destination].y, speed * delta)
		else:
			destination = (destination + 1) % len(destination_array)


func turret_destroyed():
	queue_free()
