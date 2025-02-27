extends Node2D

@onready var enemy = preload("res://Enemies/basic_enemy.tscn")

func _on_enemy_timer_timeout() -> void:
	var new_enemy = enemy.instantiate()
	new_enemy.position.y = -20
	new_enemy.position.x = randi_range(0, 448)
	$Enemies.add_child(new_enemy)
