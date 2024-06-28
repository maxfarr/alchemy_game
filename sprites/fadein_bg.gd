extends TextureRect

func _init():
	visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 2.5)
	tween.tween_callback(self.queue_free)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
