class_name Enemy
extends Area2D

@export var speed = 200
var direction = Vector2.DOWN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += speed * direction * delta
	rotation = direction.angle()


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		area.queue_free()
		queue_free()
