extends Button

@export var cost := 750
@export var purchase_sound_player: AudioStreamPlayer
@onready var orig_text = text

func _ready():
	text = orig_text + ": $"+str(cost)

func _on_pressed():
	if PlayerStats.money >= cost:
		PlayerStats.money -= cost
		PlayerStats.bombs += 1
		PlayerStats.save_stats()
		purchase_sound_player.play()
