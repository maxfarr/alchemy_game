extends Node2D

class_name EssenceIndicator
@onready var label = $CenterContainer/HBoxContainer/essence_label

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func get_label():
	return label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
