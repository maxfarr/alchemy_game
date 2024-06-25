extends Node

var rune_bag = []
var coins

var combo_scores = {
	# elements
	"double_element" : [20, 2],
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

func initDefaultBag():
	for shape in Utils.RuneShape:
		for element in Utils.Element:
			for i in range(3):
				rune_bag.append(Rune.new(shape, element))
	
func _init():
	initDefaultBag()
	coins = 0
