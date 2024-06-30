extends Node

var rune_bag = []
var upgrades_remaining = 0
var level = 0

var combo_scores = {
	# elements
	"double_element" : [20, 1],
	"triple_element" : [40, 1],
	"quad_element" : [60, 2],
	"elemental_harmony" : [120, 3],
	# shapes
	"double_shape" : [10, 1],
	"triple_shape" : [25, 1],
	"quad_shape" : [40, 2],
	"shape_harmony" : [80, 3],
	# special combos
	"shape_triad" : [30, 1],
	"total_harmony" : [200, 4],
	"stable_infusion" : [50, 2],
	"unstable_infusion" : [80, 3]
}

var upgrades = {
	# element catalysts
	# gain extra +1 mult for combos with given element
	"fire_catalyst" : 0,
	"water_catalyst" : 0,
	"earth_catalyst" : 0,
	"air_catalyst" : 0,
	"lightning_catalyst" : 0,
	"metal_catalyst" : 0,
	# triad booster
	# same but for shape triads
	"triad_booster" : 0,
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
	var bag = []
	for shape in Utils.RuneShape:
		for element in Utils.Element:
			for i in range(3):
				bag.append(Rune.new(shape, element))
	return bag
	
func _init():
	rune_bag = initDefaultBag()
	upgrades_remaining = 0
	level = 0
