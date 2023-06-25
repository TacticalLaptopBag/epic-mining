extends Button

func _on_pressed():
	for ore_name in Refs.ores:
		var count: int = PlayerStats.ore_counts[ore_name]
		PlayerStats.money += count * Refs.ores[ore_name].price
		PlayerStats.ore_counts[ore_name] = 0

		var menu_down_event := InputEventAction.new()
		menu_down_event.action = "menu"
		menu_down_event.pressed = true
		Input.parse_input_event(menu_down_event)

		get_tree().create_timer(0.1).timeout.connect(func():
			var menu_up_event := InputEventAction.new()
			menu_up_event.action = "menu"
			menu_up_event.pressed = false
			Input.parse_input_event(menu_up_event)
		)
