extends Node

class_name Utils

const RUNE_WIDTH_PX = 32
const HAND_SLOTS = 7

enum RuneShape {CIRCLE, SQUARE, TRIANGLE}
enum Element {FIRE, WATER, EARTH, AIR, LIGHTNING, METAL}

const upgrade_abbreviations = {
	# element catalysts
	# gain extra +1 mult for combos with given element
	"fire_catalyst" : "Fc",
	"water_catalyst" : "Wc",
	"earth_catalyst" : "Ec",
	"air_catalyst" : "Ac",
	"lightning_catalyst" : "Lc",
	"metal_catalyst" : "Mc",
	# triad booster
	# same but for shape triads
	"triad_booster" : "Tb",
	# gems
	# gain extra +2 mult for combos with given element, -1 to combos with opposite element
	"fire_gem" : "Fg",
	"water_gem" : "Wg",
	"earth_gem" : "Eg",
	"air_gem" : "Ag",
	"lightning_gem" : "Lg",
	"metal_gem" : "Mg",
	# +1 cast
	"pair_of_gloves" : "Pg",
	# +1 discard
	"vanishing_dust" : "Vd",
	# +2 mult to first spell
	"running_shoes" : "Rs",
	# +2 mult if spell has 3 or fewer runes
	"minimalism" : "Mn",
}

const upgrade_names = {
	# element catalysts
	# gain extra +1 mult for combos with given element
	"fire_catalyst" : "Fire Catalyst",
	"water_catalyst" : "Water Catalyst",
	"earth_catalyst" : "Earth Catalyst",
	"air_catalyst" : "Air Catalyst",
	"lightning_catalyst" : "Lightning Catalyst",
	"metal_catalyst" : "Metal Catalyst",
	# triad booster
	# same but for shape triads
	"triad_booster" : "Triad Booster",
	# gems
	# gain extra +2 mult for combos with given element, -1 to combos with opposite element
	"fire_gem" : "Fire Gem",
	"water_gem" : "Water Gem",
	"earth_gem" : "Earth Gem",
	"air_gem" : "Air Gem",
	"lightning_gem" : "Lightning Gem",
	"metal_gem" : "Metal Gem",
	# +1 cast
	"pair_of_gloves" : "Pair of Gloves",
	# +1 discard
	"vanishing_dust" : "Vanishing Dust",
	# +2 mult to first spell
	"running_shoes" : "Running Shoes",
	# +2 mult if spell has 3 or fewer runes
	"minimalism" : "Minimalism",
}

const upgrade_descriptions = {
	# element catalysts
	# gain extra +1 mult for combos with given element
	"fire_catalyst" : "+1 Mult to Fire combos",
	"water_catalyst" : "+1 Mult to Water combos",
	"earth_catalyst" : "+1 Mult to Earth combos",
	"air_catalyst" : "+1 Mult to Air combos",
	"lightning_catalyst" : "+1 Mult to Lightning combos",
	"metal_catalyst" : "+1 Mult to Metal combos",
	# triad booster
	# same but for shape triads
	"triad_booster" : "+1 Mult to Shape Triads",
	# gems
	# gain extra +2 mult for combos with given element, -1 to combos with opposite element
	"fire_gem" : "+2 Mult to Fire combos,\n-1 Mult to Water combos",
	"water_gem" : "+2 Mult to Water combos,\n-1 Mult to Fire combos",
	"earth_gem" : "+2 Mult to Earth combos,\n-1 Mult to Air combos",
	"air_gem" : "+2 Mult to Air combos,\n-1 Mult to Earth combos",
	"lightning_gem" : "+2 Mult to Lightning combos,\n-1 Mult to Metal combos",
	"metal_gem" : "+2 Mult to Metal combos,\n-1 Mult to Lightning combos",
	# +1 cast
	"pair_of_gloves" : "+1 Cast per round",
	# +1 discard
	"vanishing_dust" : "+1 Discard per round",
	# +2 mult to first spell
	"running_shoes" : "+2 Mult to first cast",
	# +2 mult if spell has 3 or fewer runes
	"minimalism" : "+2 Mult if spell has\n3 or fewer runes",
}

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
