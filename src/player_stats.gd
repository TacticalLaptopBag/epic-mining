extends Node

const SAVE_PATH = "user://epic_mining.json"

var ore_counts := {}
var money := 0
var pickaxe_speed := 1

func _ready():
	for ore_name in Refs.ores.keys():
		ore_counts[ore_name] = 0

	load_stats()

func save_stats():
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var json_ore_data := JSON.stringify(ore_counts)
	file.store_line(json_ore_data)

	var data := {
		"money": money,
		"pickaxe_speed": pickaxe_speed
	}
	var json_data = JSON.stringify(data)
	file.store_line(json_data)

	file.close()

func load_stats():
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file and not file.eof_reached():
		var ore_line = file.get_line()
		var ore_data = JSON.parse_string(ore_line)
		if ore_data:
			ore_counts = ore_data
		
		var data_line = file.get_line()
		var data = JSON.parse_string(data_line)
		if data:
			money = data["money"]
			pickaxe_speed = data["pickaxe_speed"]
