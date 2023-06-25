extends Label

@onready var orig_text := text

func _process(_delta: float):
	text = orig_text + str(PlayerStats.bombs)
