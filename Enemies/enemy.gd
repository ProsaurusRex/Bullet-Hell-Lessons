class_name Enemy
extends Area2D

# Node shortcuts
@onready var gun_marker = $Marker2D

# Exports
@export var bullet_scene: PackedScene
@export var bullet_manager: Node2D
@export var speed = 200

# Movement
var direction = Vector2.DOWN
var turn_direction = 0.0

# Shooting
var bullet_cooldown = 1.0
@onready var time_since_firing = 0#randf_range(0.0, 0.2)

# Signals
signal destroyed


func _ready() -> void:
	pass
	#if position.x >= 200:
		#turn_direction = -1.0
	#elif position.x <= 100:
		#turn_direction = 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += speed * direction * delta
	rotation = direction.angle()
	if position.y >= 150:
		direction.x = lerp(direction.x, turn_direction/2, 0.01)
	
	time_since_firing += delta
	if time_since_firing >= bullet_cooldown:
		attack()
		time_since_firing = 0


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		if area.player_bullet:
			destroyed.emit()
			area.queue_free()
			queue_free()


func attack():
	var new_bullet: Area2D = bullet_scene.instantiate()
	new_bullet.transform = gun_marker.global_transform
	new_bullet.modulate = Color("red")
	bullet_manager.add_child(new_bullet)
