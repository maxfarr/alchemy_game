extends Node2D

@onready var upgrades = 2

@onready var slots = [
	%UpgradeSlot,
	%UpgradeSlot2,
	%UpgradeSlot3,
	%UpgradeSlot4,
	%UpgradeSlot5
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
