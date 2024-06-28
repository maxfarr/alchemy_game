extends Node

class_name UpgradeTile

var upgrade_name

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	var tooltip = load("res://sprites/upgrade_tooltip.tscn").instantiate()
	tooltip.get_child(0).get_child(0).get_child(0).text = Utils.upgrade_names[upgrade_name]
	tooltip.get_child(0).get_child(1).get_child(0).text = Utils.upgrade_descriptions[upgrade_name]
	tooltip.set_position(Vector2(0, 32))
	add_child(tooltip)

func _on_mouse_exited():
	remove_child(get_child(1))
