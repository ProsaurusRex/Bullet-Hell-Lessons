class_name Player
extends Area2D

# Node shortcuts
@onready var gun_marker = $Marker2D

# Exports
@export var bullet_scene: PackedScene
@export var bullet_manager: Node2D

# Variables
var speed = 100
var bullet_cooldown = 0.2
var time_since_firing = 0.0

# Controls
var up = "p1_up"
var down = "p1_down"
var left = "p1_left"
var right = "p1_right"
var shoot = "p1_shoot"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector(left, right, up, down)
	
	position += direction * speed * delta
	# Clamp position here
	
	time_since_firing += delta
	if Input.is_action_pressed(shoot) and time_since_firing >= bullet_cooldown:
		attack()
		time_since_firing -= bullet_cooldown


func attack():
	var new_bullet = bullet_scene.instantiate()
	new_bullet.position = gun_marker.position
	bullet_manager.add_child(new_bullet)
