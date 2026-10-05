extends Control

const CROSSHAIR_COLOR := Color(1.0, 0.16, 0.12, 0.95)
const CROSSHAIR_SHADOW := Color(0.08, 0.0, 0.0, 0.9)

var touch_position := Vector2.ZERO

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	touch_position = get_viewport_rect().size * 0.75
	queue_redraw()

func _process(_delta: float) -> void:
	if DisplayServer.is_touchscreen_available():
		position = touch_position - size * 0.5
	else:
		position = get_viewport().get_mouse_position() - size * 0.5

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		touch_position = event.position

func _draw() -> void:
	var center: Vector2 = size * 0.5
	for offset: Vector2 in [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]:
		draw_line(center + offset * 7.0 + Vector2(1, 1), center + offset * 16.0 + Vector2(1, 1), CROSSHAIR_SHADOW, 4.0)
		draw_line(center + offset * 7.0, center + offset * 16.0, CROSSHAIR_COLOR, 2.0)
	draw_arc(center + Vector2(1, 1), 4.5, 0.0, TAU, 24, CROSSHAIR_SHADOW, 4.0)
	draw_arc(center, 4.5, 0.0, TAU, 24, CROSSHAIR_COLOR, 2.0)
