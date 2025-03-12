class_name SpecialAmmo
extends Area2D


@export var speed = 100


func _physics_process(delta: float) -> void:
	position.y += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
