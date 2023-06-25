extends Camera3D

const ANIM_TIME = 0.75

@export var pickaxe_range := 5

@onready var anim_player := $"pickaxe/AnimationPlayer"

var pick_ready := true
var auto_repeat := false
var current_block: MiningBlock = null
var selected_block: MiningBlock = null
var mining := false

func _ready():
	anim_player.animation_finished.connect(
		func(_anim_name: String): pick_ready = true
	)

func _unhandled_input(_event: InputEvent):
	# Don't cancel mining if we are currently mining a block
	mining = Input.is_action_pressed("mine") or current_block != null

func _physics_process(_delta: float):
	select_block()
	if mining:
		update_current_block()
		mine_current_block()
	
	anim_player.speed_scale = PlayerStats.pickaxe_speed

func get_block() -> MiningBlock:
	var mouse_pos := get_viewport().get_mouse_position()
	var from := project_ray_origin(mouse_pos)
	var to := from + project_ray_normal(mouse_pos) * pickaxe_range

	var space_state := get_world_3d().direct_space_state
	var query := PhysicsRayQueryParameters3D.create(from, to)
	var result := space_state.intersect_ray(query)
	var collider = result.get("collider")

	if collider != null and collider.is_in_group("MiningBlock"):
		return collider

	return null

func select_block():
	var look_block = get_block()
	if look_block != selected_block:
		if selected_block != null:
			selected_block.on_deselected()
		selected_block = look_block
		if selected_block != null:
			selected_block.on_selected()

func update_current_block():
	selected_block = get_block()

	if selected_block != null:
		if (current_block != null and current_block == selected_block) or current_block == null:
			# Player is still looking at current block or started mining a new block
			current_block = selected_block
			current_block.on_selected()
		else:
			# Cancel mining - player looked at another block
			current_block = null
			mining = false
	else:
		# Player is not looking at a block
		current_block = null


func mine_current_block():
	if not pick_ready: return
	if current_block == null: return

	anim_player.play("ArmatureAction")
	pick_ready = false

	current_block.health -= 1
	if current_block.health <= 0:
		current_block = null
		mining = false
