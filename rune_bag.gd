extends Node

class_name RuneBag

var RemainingRunes = []

func initDefaultBag():
	for shape in Utils.RuneShape:
		for element in Utils.Element:
			for i in range(3):
				RemainingRunes.append(Rune.new(shape, element))

func drawRune():
	if RemainingRunes.size() == 0: return null
	
	var index = range(RemainingRunes.size()).pick_random()
	return RemainingRunes.pop_at(index)
	
func _init():
	initDefaultBag()
