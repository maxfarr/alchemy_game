extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	%GameController.reset(500, 10, 3, 5)
	%black_fadein.self_modulate.a = 0.5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
