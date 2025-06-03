extends CharacterBody2D
var bullet_path=preload("res://Scenes/Bullet.tscn")

func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	#if Input.is_action_just_released("click"):
	if Input.is_action_just_pressed("ui_accept"):
		print("Test!")
		fire()

func fire():
	var bullet = bullet_path.instantiate()
	bullet.dir = rotation
	bullet.pos = $Node2D.global_position
	bullet.rot = global_rotation
	get_parent().add_child(bullet)
