extends Node2D

@onready var enemy_scene = preload("res://Enemies/enemy.tscn")

var score = 0


func _on_enemy_timer_timeout() -> void:
	var new_enemy_pos = Vector2(randi_range(16, 768/2 - 16), -20)
	create_enemy(new_enemy_pos)


func create_enemy(pos, e = enemy_scene):
	var new_enemy = e.instantiate()
	new_enemy.position = pos
	new_enemy.bullet_manager = $Bullets
	new_enemy.connect("destroyed", increase_score)
	$Enemies.add_child(new_enemy)


func increase_score(amount = 1):
	score += amount
	$Score.text = str(score)


func _on_player_damage_taken(player: Player, amount: int) -> void:
	$Health.value -= amount
	if $Health.value <= 0:
		player.destroyed()
