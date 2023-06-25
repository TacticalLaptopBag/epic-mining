extends Control

func _input(_event: InputEvent):
	if Input.is_action_just_pressed("menu"):
		visible = !visible
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if visible else Input.MOUSE_MODE_CAPTURED
