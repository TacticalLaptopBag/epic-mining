extends Control

func _input(_event: InputEvent):
	if Input.is_action_just_pressed("menu"):
		toggle_visibility()

func _enter_tree():
	visible = false

func toggle_visibility():
	visible = !visible
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if visible else Input.MOUSE_MODE_CAPTURED

func _on_continue_pressed():
	toggle_visibility()
