class_name Powerup
extends Area2D

@export var speed = 100


func _physics_process(delta: float) -> void:
	position.y += speed * delta


func apply_effect(player: Player):
	pass


func _on_area_entered(area: Area2D) -> void:
	if area is Player:
		apply_effect(area)
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
