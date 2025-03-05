class_name EnemyBoss
extends Node2D

@export var bullet_manager: Node2D
@export var target: Node2D

var number_of_turrets
var initial_position
var horizontal_movement = 50
var speed = 0.5
var time_passed = 0.0


func _ready() -> void:
	number_of_turrets = $Turrets.get_child_count()
	initial_position = position
	for t: Turret in $Turrets.get_children():
		t.bullet_manager = bullet_manager
		t.target = target
		t.connect("tree_exiting", turret_destroyed)


func _physics_process(delta: float) -> void:
	time_passed += delta
	position.x = initial_position.x + horizontal_movement * cos(time_passed * speed)
	rotation = -PI/2 - PI/16 * sin(time_passed * speed)


func turret_destroyed():
	number_of_turrets -= 1
	if number_of_turrets <= 0:
		queue_free()
