extends PanelContainer

@onready var label: Label = $"Label"

func _process(_delta):
	label.text = "$"+str(PlayerStats.money)
