class_name Enemy
extends Area2D

# Node shortcuts
@onready var gun_marker = $Marker2D

# Exports
@export var bullet_scene: PackedScene
@export var bullet_manager: Node2D

# Movement
var speed = 200
var direction = Vector2.DOWN

# Shooting
var bullet_cooldown = 1.0
var time_since_firing = 0

# Signals
signal destroyed


func _physics_process(delta: float) -> void:
	position += speed * direction * delta
	rotation = direction.angle()  # Point in the direction you're flying
	
	time_since_firing += delta
	if time_since_firing >= bullet_cooldown:
		attack()
		time_since_firing = 0


func attack():
	var new_bullet: Area2D = bullet_scene.instantiate()
	new_bullet.transform = gun_marker.global_transform
	new_bullet.modulate = Color("red")
	bullet_manager.add_child(new_bullet)


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		if area.player_bullet:
			destroyed.emit()
			area.queue_free()
			queue_free()
