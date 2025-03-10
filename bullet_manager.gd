class_name BulletManager
extends Node2D

@onready var explosion = preload("res://Projectiles/explosion.tscn")

func create_explosion(pos: Vector2):
	var new_explosion = explosion.instantiate()
	new_explosion.position = pos
	add_child.call_deferred(new_explosion)  # Call_deferred in case the bullet manager is busy
