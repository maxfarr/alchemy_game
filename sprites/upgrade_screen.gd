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
	PlayerData.upgrades_remaining = 2
	for i in range(5):
		var upgrade = Utils.upgrade_names.keys().pick_random()
		slots[i].upgrade_name = upgrade
		slots[i].get_child(0).text = Utils.upgrade_abbreviations[upgrade]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
