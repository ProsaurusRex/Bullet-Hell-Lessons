class_name Bullet
extends Area2D

var speed = 300
var player_bullet = false

@onready var explosion = preload("res://explosion.tscn")

signal on_hit


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += speed * transform.x * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_tree_exiting() -> void:
	var new_explosion = explosion.instantiate()
	new_explosion.position = position
	get_parent().add_child.call_deferred(new_explosion)
	#on_hit.emit(position)
	queue_free.call_deferred()
