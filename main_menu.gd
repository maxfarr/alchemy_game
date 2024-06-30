extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	%play_button.modulate.a = 0.0
	%how_button.modulate.a = 0.0
	%stand_sprite.stop()
	await get_tree().create_timer(3.0).timeout
	%stand_sprite.play()
	await get_tree().create_timer(1.0).timeout
	%stand_sprite.pause()
	var tween1 = create_tween()
	var tween2 = create_tween()
	tween1.tween_property(%play_button, "modulate:a", 1.0, 1.5)
	tween2.tween_property(%how_button, "modulate:a", 1.0, 1.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
