extends TextureRect

class_name RoundWinScreen

var earned

func _init(e):
	earned = e

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func set_label(e):
	%essence_earned_label.text = str(e)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
