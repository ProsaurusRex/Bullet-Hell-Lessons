extends Node2D

@onready var enemy = preload("res://Enemies/basic_enemy.tscn")
@onready var boss_scene = preload("res://Enemies/Boss/boss.tscn")

var score = 0
var boss_active = false
var boss_number = 1


func _on_enemy_timer_timeout() -> void:
	if not boss_active:
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


func create_boss():
	var new_boss = boss_scene.instantiate()
	new_boss.position = Vector2(224, -200)
	new_boss.bullet_manager = $Bullets
	new_boss.target = $Player
	new_boss.connect("tree_exiting", func(): boss_active = false)
	$Enemies.add_child.call_deferred(new_boss)
	var tween = create_tween()
	tween.tween_property(new_boss, "position:y", 200, 5.0)


func increase_score(amount = 1):
	score += amount
	$Score.text = str(score)
	if score >= 50 * boss_number and not boss_active:
		boss_active = true
		boss_number += 1
		create_boss()


func _on_player_damage_taken(player: Player, amount: int) -> void:
	$Health.value -= amount
	if $Health.value <= 0:
		player.destroyed()
