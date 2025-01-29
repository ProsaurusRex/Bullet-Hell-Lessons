class_name Bullet
extends Area2D

# Variables
@export var speed = 500


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position.y -= speed * delta
