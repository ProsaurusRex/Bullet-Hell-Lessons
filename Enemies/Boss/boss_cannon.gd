class_name Turret
extends Area2D

# Node shortcuts
@onready var gun_marker = $Marker2D

# Exports
@export var bullet_scene: PackedScene
@export var bullet_manager: Node2D
@export var target: Node2D
@export var bullet_cooldown = 0.5
@export var freeze_duration = 0.0

# Other variables
var health = 10
var rotation_speed = PI/4
var time_since_firing = 0.0
var freeze_rotation = false


func _ready() -> void:
	connect("area_entered", _on_area_entered)


func _physics_process(delta: float) -> void:
	if is_instance_valid(target) and not freeze_rotation:
		look_at(target.position)
		
	time_since_firing += delta
	if time_since_firing >= bullet_cooldown:
		attack()
		time_since_firing = 0


func attack():
	if freeze_duration > 0:
		freeze_rotation = true
		await get_tree().create_timer(freeze_duration).timeout
	var new_bullet: Area2D = bullet_scene.instantiate()
	new_bullet.transform = gun_marker.global_transform
	new_bullet.modulate = Color("red")
	if new_bullet.has_method("set_target"):
		new_bullet.set_target(target)
	bullet_manager.add_child(new_bullet)
	if freeze_duration > 0:
		await get_tree().create_timer(freeze_duration).timeout
		freeze_rotation = false


func destroy():
	queue_free()


func _on_area_entered(area):
	if area is Bullet:
		if area.player_bullet:
			health -= 1
			area.queue_free()
			if health <= 0:
				destroy()
