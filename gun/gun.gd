extends Node2D

const BULLET_SCENE: PackedScene = preload("res://bullet/bullet.tscn")

@onready var muzzle: Marker2D = $Marker2D

var touch_aim_direction := Vector2.RIGHT

func _process(_delta: float) -> void:
	if DisplayServer.is_touchscreen_available():
		look_at(global_position + touch_aim_direction * 1000.0)
	else:
		look_at(get_global_mouse_position())

	rotation_degrees = wrapf(rotation_degrees, 0.0, 360.0)
	if rotation_degrees > 90.0 and rotation_degrees < 270.0:
		scale.y = -1.0
	else:
		scale.y = 1.0

	if not DisplayServer.is_touchscreen_available() and Input.is_action_just_pressed("click"):
		_shoot()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch and event.pressed:
		var world_touch: Vector2 = get_viewport().get_canvas_transform().affine_inverse() * event.position
		var aim_vector: Vector2 = world_touch - global_position
		if aim_vector.length_squared() > 1.0:
			touch_aim_direction = aim_vector.normalized()
			look_at(world_touch)
		_shoot()

func _shoot() -> void:
	var bullet_instance: Node2D = BULLET_SCENE.instantiate() as Node2D
	get_tree().current_scene.add_child(bullet_instance)
	bullet_instance.global_position = muzzle.global_position
	bullet_instance.global_rotation = global_rotation
