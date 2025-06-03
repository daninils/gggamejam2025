extends CharacterBody2D

var bullet_scene = preload("res://scenes/bullet.tscn")
const SPEED = 200
@onready var is_reloading = false
@onready var shooty_part = $ShootyPart
@export var player_number: int = 0

func _physics_process(delta: float) -> void:
	var window_size = get_window().size
	if player_number == 0:
		# Look to the right
		look_at(Vector2(window_size.x, position.y))
	elif player_number == 1:
		# Look to the left
		look_at(Vector2(0, position.y))

	if player_number == 0:
		velocity.x = Input.get_axis("left", "right") * SPEED
		velocity.y = Input.get_axis("up", "down") * SPEED
		velocity = lerp(get_real_velocity(), velocity, 0.1)
	
	if Input.is_action_just_pressed("shoot"):
		var mouse_pos = get_global_mouse_position()
		var screen_width = get_viewport().get_visible_rect().size.x
		var is_shooting = false
		if mouse_pos.x < screen_width / 2:
			is_shooting = player_number == 0
			print("Mouse is on the left side!")
		else:
			is_shooting = player_number == 1
			print("Mouse is on the right side!")
		
		if is_shooting:
			var bullet = bullet_scene.instantiate()
			bullet.global_position = shooty_part.global_position
			bullet.direction = (shooty_part.global_position - global_position).normalized()
			$/root/Game.add_child(bullet)

	move_and_slide()

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("player") and not is_reloading:
			print("Hit enemy! ", player_number)
			is_reloading = true
			get_tree().reload_current_scene()
