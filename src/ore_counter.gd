extends Control

var ore: String
@onready var label := $"Label"

func _process(_delta):
	if ore.is_empty(): return
	label.text = ore+": "+str(PlayerStats.ore_counts[ore])
