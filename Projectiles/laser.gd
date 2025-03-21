class_name Laser
extends Bullet


func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.5, 2.0)
	await tween.finished
	queue_free()
