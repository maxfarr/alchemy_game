extends Node

class_name Utils

const RUNE_WIDTH_PX = 32
const HAND_SLOTS = 7

enum RuneShape {CIRCLE, SQUARE, TRIANGLE}
enum Element {FIRE, WATER, EARTH, AIR, LIGHTNING, METAL}

const combo_names = {
	# element chains
	"single_element" : "Single Element",
	"double_element" : "Double Element",
	"triple_element" : "Triple Element",
	"quad_element" : "Quad Element",
	# shape chains
	"single_shape" : "Single Shape",
	"double_shape" : "Double Shape",
	"triple_shape" : "Triple Shape",
	"quad_shape" : "Quad Shape",
	# 2 of one element and either 2 (stable) or 3 (unstable) of another
	"stable_infusion" : "Stable Infusion",
	"unstable_infusion" : "Unstable Infusion",
	# one of each shape
	"shape_triad" : "Shape Triad",
	# all same shape
	"shape_harmony" : "Shape Harmony",
	# all same element
	"elemental_harmony" : "Elemental Harmony",
	# all same shape and element
	"total_harmony" : "Total Harmony"
}

# i hate this, why did i do it this way
#const BaseSprites = {
	#"CIRCLE" : {
		#"FIRE" : "res://sprites/base_runes/circle_fire.png",
		#"WATER" : "res://sprites/base_runes/circle_water.png",
		#"EARTH" : "res://sprites/base_runes/circle_earth.png",
		#"AIR" : "res://sprites/base_runes/circle_air.png",
		#"LIGHTNING": "res://sprites/base_runes/circle_lightning.png",
		#"METAL": "res://sprites/base_runes/circle_metal.png"
	#},
	#"SQUARE" : {
		#"FIRE" : "res://sprites/base_runes/square_fire.png",
		#"WATER" : "res://sprites/base_runes/square_water.png",
		#"EARTH" : "res://sprites/base_runes/square_earth.png",
		#"AIR" : "res://sprites/base_runes/square_air.png",
		#"LIGHTNING": "res://sprites/base_runes/square_lightning.png",
		#"METAL": "res://sprites/base_runes/square_metal.png"
	#},
	#"TRIANGLE" : {
		#"FIRE" : "res://sprites/base_runes/triangle_fire.png",
		#"WATER" : "res://sprites/base_runes/triangle_water.png",
		#"EARTH" : "res://sprites/base_runes/triangle_earth.png",
		#"AIR" : "res://sprites/base_runes/triangle_air.png",
		#"LIGHTNING": "res://sprites/base_runes/triangle_lightning.png",
		#"METAL": "res://sprites/base_runes/triangle_metal.png"
	#}
#}

const base_sprite_indices = {
	"EARTH" : {
		"CIRCLE" : 0,
		"TRIANGLE" : 1,
		"SQUARE" : 2
	},
	"FIRE" : {
		"CIRCLE" : 3,
		"TRIANGLE" : 4,
		"SQUARE" : 5
	},
	"LIGHTNING" : {
		"CIRCLE" : 6,
		"TRIANGLE" : 7,
		"SQUARE" : 8
	},
	"WATER" : {
		"CIRCLE" : 9,
		"TRIANGLE" : 10,
		"SQUARE" : 11
	},
	"METAL" : {
		"CIRCLE" : 12,
		"TRIANGLE" : 13,
		"SQUARE" : 14
	},
	"AIR" : {
		"CIRCLE" : 15,
		"TRIANGLE" : 16,
		"SQUARE" : 17
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
