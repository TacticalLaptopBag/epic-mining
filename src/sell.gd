extends Button

func _on_pressed():
	for ore in Refs.ores:
		var count: int = PlayerStats.ore_counts[ore.display_name]
		PlayerStats.money += count * ore.price
		PlayerStats.ore_counts[ore.display_name] = 0
