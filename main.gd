extends Node2D

@export var rewards: Array[PackedScene]

@onready var enemy_scenes = [preload("res://Enemies/enemy.tscn"),
							preload("res://Enemies/seeker.tscn")]
@onready var boss_scenes = [preload("res://Enemies/Boss/boss_easy.tscn"),
							preload("res://Enemies/Boss/boss_hard.tscn")]

var score = 0
var boss_active = false
var boss_number = 1

var enemy_spacing = 32
var new_enemy_pos_x = enemy_spacing
var enemy_number = 1


func _on_enemy_timer_timeout() -> void:
	if not boss_active:
		if enemy_number % 5 == 0:
			create_enemy(Vector2(randi_range(16, 768/2 - 16), -20), enemy_scenes[1])
		else:
			create_enemy(Vector2(randi_range(16, 768/2 - 16), -20))
		enemy_number += 1
		
		### WING PATTERN ###
		#var wing_pos_x = randi_range(3, 9) * 32
		#create_enemy(Vector2(wing_pos_x, -20))
		#for i in range(1, 3):
			#create_enemy(Vector2(wing_pos_x + i * 32, -20 - 32 * i))
			#create_enemy(Vector2(wing_pos_x - i * 32, -20 - 32 * i))
		
		### WAVE PATTERN ###
		#create_enemy(Vector2(new_enemy_pos_x, -20))
		#create_enemy(Vector2(768/2 - 64 - new_enemy_pos_x, -20))
		#new_enemy_pos_x += enemy_spacing
		#if new_enemy_pos_x > 768/4 - enemy_spacing:
			#new_enemy_pos_x = enemy_spacing


func create_enemy(pos, e = enemy_scenes[0]):
	var new_enemy = e.instantiate()
	new_enemy.position = pos
	new_enemy.bullet_manager = $Bullets
	new_enemy.connect("destroyed", increase_score)
	if new_enemy.has_method("set_target"):
		new_enemy.set_target($Player)
	$Enemies.add_child(new_enemy)


func create_boss():
	var new_boss = boss_scenes[boss_number % len(boss_scenes)].instantiate()
	new_boss.position = Vector2(224, -200)
	new_boss.bullet_manager = $Bullets
	new_boss.target = $Player
	new_boss.health_per_turret = 5 * boss_number
	new_boss.connect("tree_exiting", func(): boss_active = false)
	$Enemies.add_child.call_deferred(new_boss)
	var tween = create_tween()
	tween.tween_property(new_boss, "position:y", 150, 5.0)


func increase_score(pos, amount = 1):
	score += amount
	$Score.text = str(score)
	if score >= 10 * boss_number and not boss_active:
		boss_active = true
		boss_number += 1
		create_boss()
	if randf() < 0.1:
		var new_reward = rewards[randi() % len(rewards)].instantiate()
		new_reward.position = pos
		$Bullets.add_child.call_deferred(new_reward)


func _on_player_damage_taken(player: Player, amount: int) -> void:
	$Health.value -= amount
	if $Health.value <= 0:
		player.destroyed()


func _on_player_ammo_changed(new_total: int) -> void:
	$SpecialAmmo.text = str(new_total)
