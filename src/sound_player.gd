extends AudioStreamPlayer3D

@export var sounds: Array[AudioStream]
@export var volume: float = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var random_sound = Arrays.random(sounds)
	stream = random_sound
	volume_db = volume
	play()


func _on_finished():
	queue_free()
