extends TextureRect

class_name HandSlot

@export var rune : Rune

func _get_drag_data(at_position):
	if rune != null and GameController.game_running:
		var sprite = RuneSprite.new(rune)
		sprite.set_indexed("self_modulate:a", 0.5)
		set_drag_preview(sprite)
		return {
			"rune": rune,
			"origin": self
		}
	
func _can_drop_data(at_position, data):
	return true
	
func _drop_data(at_position, data):
	var origin = data["origin"]
	
	# store temp rune value for swap
	var outgoing_rune = rune
	
	# if either slot has a rune currently, free it
	if rune != null:
		get_child(0).queue_free()
	if origin.rune != null:
		origin.get_child(0).queue_free()
		
	rune = data["rune"]
	if rune != null:
		var rune_sprite = RuneSprite.new(rune)
		rune_sprite.position = Vector2(Utils.RUNE_WIDTH_PX/2, Utils.RUNE_WIDTH_PX/2)
		add_child(rune_sprite)
	
	origin.rune = outgoing_rune
	if outgoing_rune != null:
		var rune_sprite = RuneSprite.new(outgoing_rune)
		rune_sprite.position = Vector2(Utils.RUNE_WIDTH_PX/2, Utils.RUNE_WIDTH_PX/2)
		origin.add_child(rune_sprite)
		
	%RuneDropSFX.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
