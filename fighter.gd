class_name Fighter
extends Area2D

# Node shortcuts
@onready var gun_marker = $Marker2D

# Exports
@export var bullet_scene: PackedScene
@export var bullet_manager: Node2D
@export var speed = 300
@export var bullet_cooldown = 0.3

# Variables
var time_since_firing = 0.0
var velocity = Vector2.ZERO


func attack():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.global_position = gun_marker.global_position
	bullet_manager.add_child(new_bullet)
