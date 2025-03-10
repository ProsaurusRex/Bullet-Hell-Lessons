class_name Bullet
extends Area2D

@export var speed = 300
var player_bullet = false

signal on_hit


func _physics_process(delta: float) -> void:
	position += speed * transform.x * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_tree_exiting() -> void:
	on_hit.emit(position)
	queue_free()
