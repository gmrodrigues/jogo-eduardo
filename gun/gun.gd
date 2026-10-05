extends Node2D

const BULLET_SCENE: PackedScene = preload("res://bullet/bullet.tscn")

@onready var muzzle: Marker2D = $Marker2D

var touch_aim_direction := Vector2.RIGHT

func _process(_delta: float) -> void:
	var touch_aim: Vector2 = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	if touch_aim.length_squared() > 0.01:
		touch_aim_direction = touch_aim.normalized()

	if DisplayServer.is_touchscreen_available() or touch_aim.length_squared() > 0.01:
		look_at(global_position + touch_aim_direction * 1000.0)
	else:
		look_at(get_global_mouse_position())

	rotation_degrees = wrapf(rotation_degrees, 0.0, 360.0)
	if rotation_degrees > 90.0 and rotation_degrees < 270.0:
		scale.y = -1.0
	else:
		scale.y = 1.0

	if Input.is_action_just_pressed("click"):
		var bullet_instance: Node2D = BULLET_SCENE.instantiate() as Node2D
		get_tree().current_scene.add_child(bullet_instance)
		bullet_instance.global_position = muzzle.global_position
		bullet_instance.global_rotation = global_rotation
