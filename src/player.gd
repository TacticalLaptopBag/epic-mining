extends CharacterBody3D
class_name Player

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var mouse_sensitivity = 1.0

@export var max_look_rotation = 90
@export var min_look_rotation = -90

const MOUSE_FACTOR = 0.001
const JOYPAD_FACTOR = 0.01

var _xRotation := 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@onready var camera = $"Camera3D"

func _ready():
	Refs.player = self
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent):
	if event is InputEventMouseMotion:
		_look(MOUSE_FACTOR, event.relative)
	if Input.is_action_just_pressed("menu"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else Input.MOUSE_MODE_CAPTURED 

func _process(delta: float):
	_look(JOYPAD_FACTOR, Input.get_vector("look_left", "look_right", "look_up", "look_down"))
	_move_character(delta)

func _look(factor: float, delta: Vector2):
	delta.x = -delta.x * factor * mouse_sensitivity
	delta.y = -delta.y * factor * mouse_sensitivity

	_xRotation += -delta.y
	if _xRotation >= deg_to_rad(max_look_rotation):
		delta.y = 0
		_xRotation = deg_to_rad(max_look_rotation)
	elif _xRotation <= deg_to_rad(min_look_rotation):
		delta.y = 0
		_xRotation = deg_to_rad(min_look_rotation)

	rotate_object_local(Vector3(0, 1, 0), delta.x)
	camera.rotate_object_local(Vector3(1, 0, 0), delta.y)


func _move_character(delta: float):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
