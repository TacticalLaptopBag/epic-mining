extends AudioStreamPlayer3D

var sounds_loader := ResourceArray.new("res://sounds/block_destroy")

# Called when the node enters the scene tree for the first time.
func _ready():
	var sounds := sounds_loader.loadAll()
	var random_sound = Arrays.random(sounds)
	stream = random_sound
	volume_db = -5
	play()


func _on_finished():
	queue_free()
