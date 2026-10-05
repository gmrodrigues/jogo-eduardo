extends Control

const CROSSHAIR_COLOR := Color(1.0, 0.16, 0.12, 0.95)
const CROSSHAIR_SHADOW := Color(0.08, 0.0, 0.0, 0.9)

var touch_aim_direction := Vector2.RIGHT

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	queue_redraw()

func _process(_delta: float) -> void:
	var touch_aim: Vector2 = Input.get_vector("aim_left", "aim_right", "aim_up", "aim_down")
	if DisplayServer.is_touchscreen_available() or touch_aim.length_squared() > 0.01:
		if touch_aim.length_squared() > 0.01:
			touch_aim_direction = touch_aim.normalized()
		var viewport_size: Vector2 = get_viewport_rect().size
		var aim_distance: float = minf(viewport_size.x, viewport_size.y) * 0.28
		position = viewport_size * 0.5 + touch_aim_direction * aim_distance - size * 0.5
	else:
		position = get_viewport().get_mouse_position() - size * 0.5

func _draw() -> void:
	var center: Vector2 = size * 0.5
	for offset: Vector2 in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
		draw_line(center + offset * 7.0 + Vector2(1, 1), center + offset * 16.0 + Vector2(1, 1), CROSSHAIR_SHADOW, 4.0)
		draw_line(center + offset * 7.0, center + offset * 16.0, CROSSHAIR_COLOR, 2.0)
	draw_arc(center + Vector2(1, 1), 4.5, 0.0, TAU, 24, CROSSHAIR_SHADOW, 4.0)
	draw_arc(center, 4.5, 0.0, TAU, 24, CROSSHAIR_COLOR, 2.0)
