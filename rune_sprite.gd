extends Control

class_name RuneSprite

var rune : Rune
var sheet = preload("res://sprites/base_rune_sheet.tres")

func _init(r):
	rune = r

# Called when the node enters the scene tree for the first time.
func _ready():
	var base_sprite = Sprite2D.new()
	add_child(base_sprite)
	base_sprite.texture = sheet.get_frame_texture("runes", Utils.base_sprite_indices[rune.element][rune.shape])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
