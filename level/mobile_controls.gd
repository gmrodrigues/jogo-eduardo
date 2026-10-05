extends Control

@export var show_on_desktop: bool = false

var bound_actions: Array[StringName] = []

func _ready() -> void:
	visible = show_on_desktop or DisplayServer.is_touchscreen_available()
	if not visible:
		return

	_bind_button($MovePad/Up, &"up")
	_bind_button($MovePad/Down, &"down")
	_bind_button($MovePad/Left, &"left")
	_bind_button($MovePad/Right, &"right")
	_bind_button($AimPad/Up, &"aim_up")
	_bind_button($AimPad/Down, &"aim_down")
	_bind_button($AimPad/Left, &"aim_left")
	_bind_button($AimPad/Right, &"aim_right")
	_bind_button($AimPad/Fire, &"click")

func _exit_tree() -> void:
	for action: StringName in bound_actions:
		Input.action_release(action)

func _bind_button(button: Button, action: StringName) -> void:
	bound_actions.append(action)
	button.button_down.connect(_press_action.bind(action))
	button.button_up.connect(_release_action.bind(action))

func _press_action(action: StringName) -> void:
	Input.action_press(action, 1.0)

func _release_action(action: StringName) -> void:
	Input.action_release(action)
