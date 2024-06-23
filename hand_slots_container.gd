extends VBoxContainer

class_name HandSlotsContainer

@onready var hand_slots = [
	$"../VBoxContainer/CenterContainer/HandSlot",
	$"../VBoxContainer/CenterContainer2/HandSlot",
	$"../VBoxContainer/CenterContainer3/HandSlot",
	$"../VBoxContainer/CenterContainer4/HandSlot",
	$"../VBoxContainer/CenterContainer5/HandSlot",
	$"../VBoxContainer/CenterContainer6/HandSlot",
	$"../VBoxContainer/CenterContainer7/HandSlot"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(1.0).timeout
	%RuneDrawSFX.play()
	for i in range(7):
		var rune = PlayerData.drawRune()
		
		if rune == null:
			print("Bag is empty!")
			return
		
		print(rune.shape + " / " + rune.element)
		var slot = hand_slots[i]
		slot.rune = rune
		var rune_sprite = RuneSprite.new(rune)
		slot.add_child(rune_sprite)
		rune_sprite.position = Vector2(16, 16)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
