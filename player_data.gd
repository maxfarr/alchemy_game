extends Node

var remaining_runes = []
var coins

func initDefaultBag():
	for shape in Utils.RuneShape:
		for element in Utils.Element:
			for i in range(3):
				remaining_runes.append(Rune.new(shape, element))

func drawRune():
	if remaining_runes.size() == 0: return null
	
	var index = range(remaining_runes.size()).pick_random()
	return remaining_runes.pop_at(index)
	
func _init():
	initDefaultBag()
	coins = 0
