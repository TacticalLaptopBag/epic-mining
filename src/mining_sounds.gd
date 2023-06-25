extends AudioStreamPlayer3D

@export var destroy_sound_emitter: PackedScene
@export var sounds: Array[AudioStream]

func _on_health_changed(_health: int):
	var random_sound = Arrays.random(sounds)
	stream = random_sound
	play()

func _on_death(_ore: Ore):
	var emitter = destroy_sound_emitter.instantiate()
	emitter.position = position
	get_parent().get_parent().add_child(emitter)
