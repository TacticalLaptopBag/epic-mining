extends RigidBody3D

@export var explode_time := 3
@export var sound_player: PackedScene
@export var explode_sounds: Array[AudioStream]
@export var explosion_shape: Shape3D

func _ready():
	var timer = get_tree().create_timer(explode_time)
	timer.timeout.connect(explode)

func explode():
	var query = PhysicsShapeQueryParameters3D.new()
	query.shape = explosion_shape
	query.transform.origin = global_position

	var space_state := get_world_3d().direct_space_state
	var result := space_state.intersect_shape(query, 128)
	var blocks_in_range: Array[MiningBlock] = []
	for result_item in result:
		if result_item.collider.is_in_group("MiningBlock"):
			blocks_in_range.push_back(result_item.collider)


	for block in blocks_in_range:
		block.health = 0

	var emitter = sound_player.instantiate()
	emitter.sounds = explode_sounds
	emitter.position = position
	get_parent().add_child(emitter)
	queue_free()
