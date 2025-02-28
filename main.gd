extends Node2D

@onready var enemy = preload("res://Enemies/basic_enemy.tscn")
#@onready var explosion = preload("res://explosion.tscn")

var score = 0


func _on_enemy_timer_timeout() -> void:
	var wing_pos_x = randi_range(3, 9) * 32
	create_enemy(Vector2(wing_pos_x, -20))
	for i in range(1, 3):
		create_enemy(Vector2(wing_pos_x + i * 32, -20 - 32 * i))
		create_enemy(Vector2(wing_pos_x - i * 32, -20 - 32 * i))
	#create_enemy(Vector2(randi_range(0, 448), -20))


func create_enemy(pos, e = enemy):
	var new_enemy = e.instantiate()
	new_enemy.position = pos
	new_enemy.bullet_manager = $Bullets
	new_enemy.connect("destroyed", increase_score)
	$Enemies.add_child(new_enemy)


func increase_score(amount = 1):
	score += amount
	$Score.text = str(score)


#func create_explosion(pos: Vector2):
	#var new_explosion = explosion.instantiate()
	#new_explosion.position = pos
	#$Bullets.add_child(new_explosion)
