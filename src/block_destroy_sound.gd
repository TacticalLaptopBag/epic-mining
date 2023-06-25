extends AudioStreamPlayer3D

@export var sounds: Array[AudioStream]

# Called when the node enters the scene tree for the first time.
func _ready():
	var random_sound = Arrays.random(sounds)
	stream = random_sound
	volume_db = -5
	play()


func _on_finished():
	queue_free()
