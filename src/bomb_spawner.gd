extends Node3D

@export var bomb: PackedScene
@export var throw_force: float = 10
@export var cooldown: int = 10

func _unhandled_input(_event: InputEvent):
	if Input.is_action_just_pressed("bomb"):
		spawn_bomb()

func spawn_bomb():
	if PlayerStats.bombs < 1: return
	PlayerStats.bombs -= 1

	var force_direction := -global_transform.basis.z
	var force := force_direction * throw_force

	var new_bomb: RigidBody3D = bomb.instantiate()
	get_parent().get_parent().get_parent().add_child(new_bomb)
	new_bomb.global_position = global_transform.origin
	new_bomb.apply_impulse(force)
