extends Label

class_name ExtraEssenceIndicator

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property(self, "self_modulate:a", 0.0, 0.5).set_delay(0.5)
	tween.tween_callback(self.queue_free)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
