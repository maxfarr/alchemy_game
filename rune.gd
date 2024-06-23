extends Node

class_name Rune

var shape
var element
var texture

func _init(s, e):
	shape = s
	element = e
	texture = Image.load_from_file(Utils.BaseSprites[s][e])
