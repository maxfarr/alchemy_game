extends Node

class_name RuneBag

var RemainingRunes = []

func initDefaultBag():
	for shape in Utils.RuneShape:
		for element in Utils.Element:
			for i in range(3):
				RemainingRunes.append(Rune.new(shape, element))

func drawRune():
	return RemainingRunes.pop_at(range(RemainingRunes.size()).pick_random())
	
func _init():
	initDefaultBag()
