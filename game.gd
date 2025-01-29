extends Node2D

@onready var bullet_manager = $Bullets

@export var enemy_scene: PackedScene


func _on_enemy_spawn_timer_timeout() -> void:
	var new_enemy = enemy_scene.instantiate()
	new_enemy.position.y = -20
	new_enemy.position.x = randi_range(0, 600)
	new_enemy.bullet_manager = bullet_manager
	add_child(new_enemy)
