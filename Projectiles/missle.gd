extends Bullet

var target: Node2D
var turn_speed = 3 * PI/4

func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		var target_direction = position.direction_to(target.global_position)
		rotation += transform.x.cross(target_direction) * turn_speed * delta

	super._physics_process(delta)
	if speed <= 500:
		speed += 500 * delta
		if not player_bullet:
			turn_speed -= PI/2 * delta


func set_target(new_target):
	if is_instance_valid(new_target):
		target = new_target


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		if area.player_bullet:
			area.queue_free()
			queue_free()
