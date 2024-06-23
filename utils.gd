extends Node

class_name Utils

const RUNE_WIDTH_PX = 32

enum RuneShape {CIRCLE, SQUARE, TRIANGLE}
enum Element {FIRE, WATER, EARTH, LIGHTNING, METAL}

# i hate this, why did i do it this way
const BaseSprites = {
	"CIRCLE" : {
		"FIRE" : "res://sprites/base_runes/circle_fire.png",
		"WATER" : "res://sprites/base_runes/circle_water.png",
		"EARTH" : "res://sprites/base_runes/circle_earth.png",
		"LIGHTNING": "res://sprites/base_runes/circle_lightning.png",
		"METAL": "res://sprites/base_runes/circle_metal.png"
	},
	"SQUARE" : {
		"FIRE" : "res://sprites/base_runes/square_fire.png",
		"WATER" : "res://sprites/base_runes/square_water.png",
		"EARTH" : "res://sprites/base_runes/square_earth.png",
		"LIGHTNING": "res://sprites/base_runes/square_lightning.png",
		"METAL": "res://sprites/base_runes/square_metal.png"
	},
	"TRIANGLE" : {
		"FIRE" : "res://sprites/base_runes/triangle_fire.png",
		"WATER" : "res://sprites/base_runes/triangle_water.png",
		"EARTH" : "res://sprites/base_runes/triangle_earth.png",
		"LIGHTNING": "res://sprites/base_runes/triangle_lightning.png",
		"METAL": "res://sprites/base_runes/triangle_metal.png"
	}
}
