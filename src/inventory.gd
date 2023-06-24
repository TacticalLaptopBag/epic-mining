extends Control

@onready var ore_counter: PackedScene = load("res://scenes/ore_counter.tscn")
var ore_loader = ResourceArray.new("res://ores")

func _ready():
	var ores := ore_loader.loadAll()
	for i in ores.size():
		var new_counter := ore_counter.instantiate() as Control
		new_counter.ore = ores[i].display_name
		new_counter.position.y -= new_counter.size.y * i
		add_child(new_counter)
