extends Label

var block_size := Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	var mining_block := preload("res://scenes/mining_block.tscn")
	block_size = mining_block.instantiate().size

func _physics_process(_delta: float):
	var player_pos := Refs.player.position
	var player_feet := player_pos.y - 1
	var player_depth: int = round(max(-player_feet / block_size.y, 0))
	print(str(-player_feet / block_size.y))
	text = "Depth: "+str(player_depth)
