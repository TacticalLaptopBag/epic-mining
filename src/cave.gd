extends Node3D

const DEFAULT_ORE_TYPE := Ore.Type.DIRT

@onready var mining_block := preload("res://scenes/mining_block.tscn")
@onready var walls := preload("res://scenes/walls.tscn")
@export var walls_container: Node3D
var ores: Array = []
var default_ore: Ore
var rng := RandomNumberGenerator.new()
var block_size := Vector3.ZERO
var current_depth := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	load_ores()
	for depth in 5:
		spawn_layer()

func _physics_process(_delta):
	check_player_depth()
	
func load_ores():
	ores = Refs.ores.values()
	default_ore = Arrays.find(ores, func(ore: Ore):
		return ore.block_type == DEFAULT_ORE_TYPE
	)
	
func spawn_layer():
	for x in 10:
		for z in 10:
			spawn_block(Vector3(x, -current_depth, z))
	spawn_walls()
	
	current_depth += 1
	
func spawn_block(grid_position: Vector3):
	var new_block := mining_block.instantiate() as MiningBlock
	if block_size == Vector3.ZERO:
		block_size = new_block.size

	var real_position = grid_position * block_size
	new_block.position = real_position

	var depth = -new_block.position.y / 2.0
	var ore = get_random_ore(depth)
	new_block.ore = ore
	add_child(new_block)
	
	print("Ore Spawned: "+str(ore.display_name))

func spawn_walls():
	var new_walls := walls.instantiate() as Node3D
	new_walls.position.y = -current_depth * block_size.y
	walls_container.add_child(new_walls)


func get_random_ore(depth: int) -> Ore:
	# Source: https://www.youtube.com/watch?v=XyNb41Zpeuo
	rng.randomize()
	var random := rng.randf()
	var num_for_adding := 0.0
	var total := 0.0

	# Find ores that can spawn at this depth
	var possible_ores = ores.filter(func(ore: Ore):
		return ore.minimum_depth <= depth
	)

	# Get total chances
	for ore in possible_ores:
		total += ore.chance_of_spawn

	for ore in possible_ores:
		if ore.chance_of_spawn / total + num_for_adding >= random:
			return ore
		else:
			num_for_adding += ore.chance_of_spawn / total

	# Somehow missed all chance checks. Spawn default ore
	return default_ore

func check_player_depth():
	var player_depth = -Refs.player.position.y / block_size.y
	if current_depth - 2 <= player_depth:
		for i in 3:
			spawn_layer()
