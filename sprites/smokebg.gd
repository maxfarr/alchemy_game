extends AnimatedSprite2D

var backwards = false

# Called when the node enters the scene tree for the first time.
func _ready():
	play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_animation_finished():
	if backwards:
		backwards = false
		play()
	else:
		backwards = true
		play_backwards()
