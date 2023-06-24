extends Control

@onready var ore_counter: PackedScene = load("res://scenes/ore_counter.tscn")
@onready var money_counter: PackedScene = load("res://scenes/money_counter.tscn")
var ore_loader = ResourceArray.new("res://ores")

func _ready():
	var money_label := money_counter.instantiate() as Control
	add_child(money_label)

	var ores := ore_loader.loadAll()
	for i in ores.size():
		var new_counter := ore_counter.instantiate() as Control
		new_counter.ore = ores[i]
		new_counter.position.y -= new_counter.size.y * (i + 1)
		add_child(new_counter)
