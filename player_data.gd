extends Node

var rune_bag = []
var essence = 0

var combo_scores = {
	# elements
	"double_element" : [2000, 2],
	"triple_element" : [40, 3],
	"quad_element" : [80, 4],
	"elemental_harmony" : [200, 5],
	# shapes
	"double_shape" : [10, 1],
	"triple_shape" : [25, 2],
	"quad_shape" : [50, 3],
	"shape_harmony" : [120, 4],
	# special combos
	"shape_triad" : [30, 2],
	"total_harmony" : [300, 7],
	"stable_infusion" : [50, 4],
	"unstable_infusion" : [80, 5]
}

var upgrades = {
	# element catalysts
	# gain extra +1 mult for combos with given element
	"fire_catalyst" : 3,
	"water_catalyst" : 1,
	"earth_catalyst" : 0,
	"air_catalyst" : 0,
	"lightning_catalyst" : 0,
	"metal_catalyst" : 0,
	# triad booster
	# same but for shape triads
	"triad_booster" : 1,
	# gems
	# gain extra +2 mult for combos with given element, -1 to combos with opposite element
	"fire_gem" : 0,
	"water_gem" : 0,
	"earth_gem" : 0,
	"air_gem" : 0,
	"lightning_gem" : 0,
	"metal_gem" : 0,
	# +1 cast
	"pair_of_gloves" : 0,
	# +1 discard
	"vanishing_dust" : 0,
	# +2 mult to first spell
	"running_shoes" : 0,
	# +2 mult if spell has 3 or fewer runes
	"minimalism" : 0,
}

func initDefaultBag():
	for shape in Utils.RuneShape:
		for element in Utils.Element:
			for i in range(3):
				rune_bag.append(Rune.new(shape, element))
	
func _init():
	initDefaultBag()
	essence = 0
