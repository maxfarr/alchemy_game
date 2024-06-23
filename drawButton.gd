extends Button

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_pressed():
	for i in range(7):
		var rune = PlayerData.drawRune()
		
		if rune == null:
			print("Bag is empty!")
			return
		
		print(rune.shape + " / " + rune.element)
		var slot = $"../VBoxContainer".hand_slots[i]
		slot.rune = rune
		var rune_sprite = RuneSprite.new(rune)
		slot.add_child(rune_sprite)
		rune_sprite.position = Vector2(16, 16)
