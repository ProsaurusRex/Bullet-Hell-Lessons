class_name Turret
extends Area2D

# Node shortcuts
@onready var gun_marker = $Marker2D

# Exports
@export var bullet_scene: PackedScene
@export var bullet_manager: Node2D
@export var target: Node2D

# Other variables
var health = 10
var rotation_speed = PI/4
var bullet_cooldown = 0.5
var time_since_firing = 0.0


func _ready() -> void:
	connect("area_entered", _on_area_entered)


func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		look_at(target.position)
		
		time_since_firing += delta
		if time_since_firing >= bullet_cooldown:
			attack()
			time_since_firing = 0


func attack():
	var new_bullet: Area2D = bullet_scene.instantiate()
	new_bullet.transform = gun_marker.global_transform
	new_bullet.modulate = Color("red")
	bullet_manager.add_child(new_bullet)


func destroy():
	queue_free()


func _on_area_entered(area):
	if area is Bullet:
		if area.player_bullet:
			health -= 1
			area.queue_free()
			if health <= 0:
				destroy()
