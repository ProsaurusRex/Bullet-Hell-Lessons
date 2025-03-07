#class_name Player
extends Area2D

# Node shortcuts
@onready var gun_marker: Marker2D = $Marker2D

# Variables for Bullets and Shooting
@export var bullet_scene: PackedScene
@export var bullet_manager: Node2D
var bullet_cooldown = 0.2
var time_since_firing = 0.0

# Variables
var speed = 200

# Signals
signal damage_taken(player, amount)


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left", "right", "up", "down")  # Get four-way direction input
	position += direction * speed * delta
	
	# Stop player going off-screen. Clamp takes a value, and fixes it within a certain range.
	position.x = clamp(position.x, 0, 768/2)  
	position.y = clamp(position.y, 0, 896/2)
	
	time_since_firing += delta  # Count how long since we've fired in seconds
	if Input.is_action_pressed("shoot") and time_since_firing >= bullet_cooldown:
		attack()
		time_since_firing = 0


func attack():  # Shoot bullets
	print("Pew pew!")
