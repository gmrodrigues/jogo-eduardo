extends Node2D

const SPEED: float = 700.0

var lifetime: float = 3.0

func _physics_process(delta: float) -> void:
	global_position += Vector2.RIGHT.rotated(global_rotation) * SPEED * delta
	lifetime -= delta
	if lifetime <= 0.0:
		queue_free()

func _on_area_2d_body_entered(body: Node) -> void:
	if body.is_in_group("enemies") and body.has_method("die"):
		body.call("die")
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
