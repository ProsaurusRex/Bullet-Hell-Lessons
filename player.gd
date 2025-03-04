class_name Player
extends Area2D

# Node shortcuts
@onready var gun_marker = $Marker2D
@onready var health_bar: TextureProgressBar = $CanvasLayer/Health

# Variables for Bullets and Shooting
@export var bullet_scene: PackedScene
@export var bullet_manager: Node2D
var bullet_cooldown = 0.2
var time_since_firing = 0.0
var bullet_count = 1.0
const MAX_BULLET_COUNT = 5.0

# Variables
var speed = 200

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
	
	$Sprite2D.rotation = lerp($Sprite2D.rotation, direction.x * PI/15 + PI/2, 0.1)  # Rotate player if moving
	
	# Clamp position here
	
	time_since_firing += delta
	if Input.is_action_pressed(shoot) and time_since_firing >= bullet_cooldown:
		attack()
		time_since_firing = 0


func attack():
	for i in range(bullet_count):
		var new_bullet = bullet_scene.instantiate()
		new_bullet.transform = gun_marker.global_transform
		new_bullet.rotation += (bullet_count-1)/2 * PI/8 - i * PI/8  # Spread bullets over an angle of PI/8
		new_bullet.player_bullet = true
		bullet_manager.add_child(new_bullet)


func take_damage(amount = 1):
	health_bar.value -= amount
	if health_bar.value <= 0:
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		if not area.player_bullet:
			take_damage()
			area.queue_free()
	elif area is Enemy:
		take_damage()
