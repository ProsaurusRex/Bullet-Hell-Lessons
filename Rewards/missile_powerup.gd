extends Powerup

@export var special_ammo: PackedScene


func apply_effect(player: Player):
	var old_bullets = player.bullet_scene
	if old_bullets != special_ammo:
		player.bullet_scene = special_ammo
		var timer = get_tree().create_timer(5.0)
		timer.connect("timeout", func(): player.bullet_scene = old_bullets)
