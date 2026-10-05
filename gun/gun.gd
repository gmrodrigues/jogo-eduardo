extends Node2D

const BULLET_SCENE: PackedScene = preload("res://bullet/bullet.tscn")

@onready var muzzle: Marker2D = $Marker2D

func _process(_delta: float) -> void:
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
