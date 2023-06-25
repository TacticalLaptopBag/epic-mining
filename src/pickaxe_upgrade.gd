extends Button

@export var cost := 200
@export var purchase_sound_player: AudioStreamPlayer
@export var speed_increase := 0.1
@onready var orig_text = text

func _ready():
    text = orig_text + ": $"+str(cost)

func _on_pressed():
    if PlayerStats.money >= cost:
        PlayerStats.money -= cost
        PlayerStats.pickaxe_speed += speed_increase
        PlayerStats.save_stats()
        purchase_sound_player.play()
