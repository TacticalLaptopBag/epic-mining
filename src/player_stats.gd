extends Node

@export var ore_counts := {}

func _ready():
    var ores_loader := ResourceArray.new("res://ores")
    var ores := ores_loader.loadAll()
    for ore in ores:
        ore_counts[ore.display_name] = 0
