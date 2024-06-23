extends VBoxContainer

class_name HandSlotsContainer

@onready var hand_slots = [
	$"../VBoxContainer/CenterContainer/HandSlot",
	$"../VBoxContainer/CenterContainer2/HandSlot",
	$"../VBoxContainer/CenterContainer3/HandSlot",
	$"../VBoxContainer/CenterContainer4/HandSlot",
	$"../VBoxContainer/CenterContainer5/HandSlot",
	$"../VBoxContainer/CenterContainer6/HandSlot",
	$"../VBoxContainer/CenterContainer7/HandSlot"
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
