class_name Player
extends Fighter


# Controls
var up = "p1_up"
var down = "p1_down"
var left = "p1_left"
var right = "p1_right"
var shoot = "p1_shoot"

var health = 3

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = Input.get_vector(left, right, up, down)
	velocity = lerp(velocity, direction * speed, 0.2)
	
	position += velocity * delta
	# Clamp position here
	
	time_since_firing += delta
	if Input.is_action_pressed(shoot) and time_since_firing >= bullet_cooldown:
		time_since_firing = 0
		attack()


func _on_area_entered(area: Area2D) -> void:
	health -= 1
	area.queue_free()
	if health <= 0:
		queue_free()
