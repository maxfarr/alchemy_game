extends Node

class_name Utils

const RUNE_WIDTH_PX = 32

enum RuneShape {CIRCLE, SQUARE, TRIANGLE}
enum Element {FIRE, WATER, EARTH, AIR, LIGHTNING, METAL}

const combo_names = {
	# element
	"single_element" : "Single Element",
	"double_element" : "Double Element",
	"triple_element" : "Triple Element",
	"quad_element" : "Quad Element",
	# all same element
	"pure_infusion" : "Pure Infusion",
	#shapes
	"single_shape" : "Single Shape",
	"double_shape" : "Double Shape",
	"triple_shape" : "Triple Shape",
	"quad_shape" : "Quad Shape",
	# all same shape
	"balanced_infusion" : "Balanced Infusion",
	# all same shape and element
	"total_infusion" : "Total Infusion"
}

# i hate this, why did i do it this way
const BaseSprites = {
	"CIRCLE" : {
		"FIRE" : "res://sprites/base_runes/circle_fire.png",
		"WATER" : "res://sprites/base_runes/circle_water.png",
		"EARTH" : "res://sprites/base_runes/circle_earth.png",
		"AIR" : "res://sprites/base_runes/circle_air.png",
		"LIGHTNING": "res://sprites/base_runes/circle_lightning.png",
		"METAL": "res://sprites/base_runes/circle_metal.png"
	},
	"SQUARE" : {
		"FIRE" : "res://sprites/base_runes/square_fire.png",
		"WATER" : "res://sprites/base_runes/square_water.png",
		"EARTH" : "res://sprites/base_runes/square_earth.png",
		"AIR" : "res://sprites/base_runes/square_air.png",
		"LIGHTNING": "res://sprites/base_runes/square_lightning.png",
		"METAL": "res://sprites/base_runes/square_metal.png"
	},
	"TRIANGLE" : {
		"FIRE" : "res://sprites/base_runes/triangle_fire.png",
		"WATER" : "res://sprites/base_runes/triangle_water.png",
		"EARTH" : "res://sprites/base_runes/triangle_earth.png",
		"AIR" : "res://sprites/base_runes/triangle_air.png",
		"LIGHTNING": "res://sprites/base_runes/triangle_lightning.png",
		"METAL": "res://sprites/base_runes/triangle_metal.png"
	}
}

const element_opposites = {
	"FIRE" : "WATER",
	"WATER" : "FIRE",
	"EARTH" : "AIR",
	"AIR" : "EARTH",
	"LIGHTNING" : "METAL",
	"METAL" : "LIGHTNING"
}
