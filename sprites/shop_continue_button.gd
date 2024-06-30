extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func go_to_level_screen():
	get_tree().change_scene_to_file("res://sprites/level_screen.tscn")

func _on_pressed():
	PlayerData.level += 1
	%bg_fadein.self_modulate.a = 0.0
	%bg_fadein.visible = true
	var tween = create_tween()
	tween.tween_property(%bg_fadein, "self_modulate:a", 1.0, 1.5)
	tween.tween_callback(go_to_level_screen)
