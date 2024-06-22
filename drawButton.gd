extends Button

@onready var bag = $"../RuneBag"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_pressed():
	var rune = bag.drawRune()
	
	print("Bag is empty!" if rune == null else rune.shape + " / " + rune.element)
