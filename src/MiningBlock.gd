extends CSGBox3D
class_name MiningBlock

var ore: Ore : set = set_ore
@onready var selection: Node = $"Selection"

var health := 5 : get = get_health, set = set_health
signal on_health_changed(health: int)
signal on_death(block: MiningBlock)

@onready var textures := [
	load("res://textures/destroy5.png"),
	load("res://textures/destroy4.png"),
	load("res://textures/destroy3.png"),
	load("res://textures/destroy2.png"),
	null,
]
@onready var sprites := [
	$"Right",
	$"Left",
	$"Front",
	$"Back",
	$"Top",
	$"Bottom",
]

func _ready():
	add_to_group("MiningBlock")

func set_ore(value: Ore):
	material = value.material
	ore = value

func get_health() -> int:
	return health

func set_health(value: int):
	health = value

	if(health <= 0):
		on_death.emit(self)
		death()
		queue_free()
	else:
		update_decals()

	on_health_changed.emit(value)


func update_decals():
	var texture = textures[health-1]
	for sprite in sprites:
		sprite.texture = texture

func death():
	PlayerStats.ore_counts[ore.display_name] += 1
	PlayerStats.save_stats()

func on_selected():
	selection.visible = true

func on_deselected():
	selection.visible = false
