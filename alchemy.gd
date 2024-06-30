extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	%GameController.reset(Utils.levels[PlayerData.level]["score_to_beat"])
	%black_fadein.self_modulate.a = 0.0
	for upgrade in PlayerData.upgrades:
		for i in range(PlayerData.upgrades[upgrade]):
			var upgrade_tile = load("res://sprites/upgrade_tile.tscn").instantiate()
			upgrade_tile.upgrade_name = upgrade
			upgrade_tile.get_child(0).get_child(0).text = Utils.upgrade_abbreviations[upgrade]
			%Upgrades.add_child(upgrade_tile)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
