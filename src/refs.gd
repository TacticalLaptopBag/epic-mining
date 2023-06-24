extends Node

var player: Player
var ores := {}

func _ready():
    var ores_loader := ResourceArray.new("res://ores")
    var ore_rscs := ores_loader.loadAll()
    for ore_rsc in ore_rscs:
        ores[ore_rsc.display_name] = ore_rsc
