extends Node2D

var enemy_scene = preload("res://scenes/enemy.tscn")
var player_scene = preload("res://Scenes/Player.tscn")

@onready var player = $Player1

func _on_timer_timeout() -> void:
	var enemy = enemy_scene.instantiate()
	var player = player_scene.instantiate()

	if player.global_position != null:
		enemy.global_position = player.global_position

		while enemy.global_position.distance_squared_to(player.global_position) < 10000:
			enemy.global_position.x = randi_range(0, get_viewport_rect().size.x)
			enemy.global_position.y = randi_range(0, get_viewport_rect().size.y)

	#add_child(enemy)
