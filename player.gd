class_name Player
extends Area2D

# Node shortcuts
@onready var gun_marker: Marker2D = $Marker2D

# Variables for Bullets and Shooting
@export var player_sprite: Texture = preload("res://Sprites/Ships/ship_0004.png")
@export var bullet_scene: PackedScene
@export var bullet_manager: Node2D
var bullet_cooldown = 0.2
var time_since_firing = 0.0
var bullet_count = 1.0  # Float, so it can be used in division
const MAX_BULLET_COUNT = 5.0

# Special
@export var special_projectile: PackedScene
var special_ammo = 5

# Variables
var speed = 200

# Controls
@export_group("Controls")
@export var up = "p1_up"
@export var down = "p1_down"
@export var left = "p1_left"
@export var right = "p1_right"
@export var shoot = "p1_shoot"

signal damage_taken(player, amount)
signal ammo_changed(new_total)


func _ready():
	ammo_changed.emit(special_ammo)
	$Sprite2D.texture = player_sprite


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector(left, right, up, down)  # Get four-way direction
	position += direction * speed * delta
	
	# Stop player going off-screen. Clamp takes a value, and fixes it within a certain range.
	position.x = clamp(position.x, 0, 768/2)  
	position.y = clamp(position.y, 0, 896/2)
	
	time_since_firing += delta  # Count how long since we've fired in seconds
	if Input.is_action_pressed(shoot) and time_since_firing >= bullet_cooldown:
		attack()
		time_since_firing = 0
	
	if Input.is_action_just_pressed("p1_special") and special_ammo > 0:
		special()


func attack():  # Shoot bullets
	for x in range(bullet_count):
		var new_bullet = bullet_scene.instantiate()
		new_bullet.transform = gun_marker.global_transform  # Match the bullet's transform to the Marker2D
		new_bullet.rotation += (bullet_count-1)/2 * PI/8 - x * PI/8  # Spread bullets by an angle of PI/8
		new_bullet.player_bullet = true  # This is a player's bullet
		new_bullet.connect("on_hit", bullet_manager.create_explosion)
		bullet_manager.add_child(new_bullet)


func special():
	var enemy_targets = get_tree().get_nodes_in_group("Enemy")
	var target_index = 0
	while special_ammo > 0 and enemy_targets:
		special_ammo -= 1
		ammo_changed.emit(special_ammo)
		time_since_firing = 0.0
		gun_marker.rotation = (randf() - 0.5) * 3*PI/4
		
		var new_bullet = special_projectile.instantiate()
		new_bullet.transform = gun_marker.global_transform  # Match the bullet's transform to the Marker2D
		new_bullet.player_bullet = true  # This is a player's bullet
		new_bullet.connect("on_hit", bullet_manager.create_explosion)
		if new_bullet.has_method("set_target"):
			new_bullet.set_target(enemy_targets[target_index])
			target_index = (target_index + 1) % len(enemy_targets)
		bullet_manager.add_child(new_bullet)
		
		await get_tree().create_timer(0.1).timeout
	
	gun_marker.rotation = 0


func take_damage(amount = 1):
	damage_taken.emit(self, amount)


func destroyed():
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		if not area.player_bullet:
			take_damage()
			if area is not Laser:
				area.queue_free()
	
	elif area is Enemy:
		take_damage()
	
	elif area is Powerup:
		if bullet_count < MAX_BULLET_COUNT:
			bullet_count += 1.0
		special_ammo += 10
		ammo_changed.emit(special_ammo)
		area.queue_free()
	
	elif area is Medpack:
		damage_taken.emit(self, -1)
		area.queue_free()
	
	elif area is SpecialAmmo:
		special_ammo += 3
		ammo_changed.emit(special_ammo)
		area.queue_free()
