extends TextureRect

var upgrade_name

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	var tooltip = load("res://sprites/upgrade_tooltip.tscn").instantiate()
	tooltip.get_child(0).get_child(0).get_child(0).text = Utils.upgrade_names[upgrade_name]
	tooltip.get_child(0).get_child(1).get_child(0).text = Utils.upgrade_descriptions[upgrade_name]
	tooltip.set_position(Vector2(-59, 72))
	add_child(tooltip)

func _on_mouse_exited():
	remove_child(get_child(1))

func _on_gui_input(event):
	if PlayerData.upgrades_remaining > 0:
		if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
			%UpgradeSFX.play()
			PlayerData.upgrades[upgrade_name] += 1
			PlayerData.upgrades_remaining -= 1
			self.queue_free()
