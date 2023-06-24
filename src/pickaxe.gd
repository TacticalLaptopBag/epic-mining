extends Camera3D

const ANIM_TIME = 0.75

@export var pickaxe_range := 5

@onready var anim_player := $"pickaxe/AnimationPlayer"

var pick_ready := true
var auto_repeat := false
var current_block: MiningBlock = null

func _ready():
	anim_player.animation_finished.connect(
		func(_anim_name: String): pick_ready = true
	)

func _physics_process(_delta):
	if Input.is_action_pressed("mine"):
		update_current_block()
		mine_current_block()

func update_current_block():
	var mouse_pos := get_viewport().get_mouse_position()
	var from := project_ray_origin(mouse_pos)
	var to := from + project_ray_normal(mouse_pos) * pickaxe_range

	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	var result := space_state.intersect_ray(query)
	var collider = result.get("collider")

	if collider != null and collider.is_in_group("MiningBlock"):
		current_block = collider
	else:
		current_block = null


func mine_current_block():
	if not pick_ready: return
	if current_block == null: return

	anim_player.play("ArmatureAction")
	pick_ready = false

	current_block.health -= 1
	if current_block.health <= 0:
		current_block = null
