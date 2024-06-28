extends VBoxContainer

class_name HandSlotsContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1.0).timeout
	%RuneDrawSFX.play()
	for i in range(Utils.HAND_SLOTS):
		var rune = %GameController.drawRune()
		
		if rune == null:
			print("Bag is empty!")
			return
		
		print(rune.shape + " / " + rune.element)
		var slot = %VBoxContainer.get_child(i).get_child(0)
		slot.rune = rune
		var rune_sprite = RuneSprite.new(rune)
		slot.add_child(rune_sprite)
		rune_sprite.position = Vector2(16, 16)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
