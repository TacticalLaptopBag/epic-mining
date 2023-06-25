extends Node
# This isn't ideal, but I'm not working on this long term and this gets the job done

var player: Player
var ores := {}

func _ready():
	var ore_rscs := [
		preload("res://ores/diamond.tres"),
		preload("res://ores/dirt.tres"),
		preload("res://ores/gold.tres"),
		preload("res://ores/iron.tres"),
		preload("res://ores/stone.tres"),
	]
	for ore_rsc in ore_rscs:
		print("Loaded Ore Resource: "+ore_rsc.display_name)
		ores[ore_rsc.display_name] = ore_rsc
