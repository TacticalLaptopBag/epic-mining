extends Control

var ore: Ore
@onready var label: Label = $"Label"

func _process(_delta):
	label.text = ore.display_name+": "+str(PlayerStats.ore_counts[ore.display_name])
