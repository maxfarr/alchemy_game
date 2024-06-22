extends Button

@onready var bag = $"../RuneBag"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _button_pressed():
	var rune = bag.drawRune()
	print(Utils.RuneShape.keys()[rune.shape] + " " + Utils.Element.keys()[rune.element])
