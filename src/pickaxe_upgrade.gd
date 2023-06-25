extends Button

@export var cost := 200
@export var speed_increase := 0.1

func _ready():
    text = "Upgrade Pickaxe: "+str(cost)

func _on_pressed():
    if PlayerStats.money >= cost:
        PlayerStats.money -= cost
        PlayerStats.pickaxe_speed += speed_increase
