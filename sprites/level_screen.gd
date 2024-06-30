extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	%level_label.text = "BOSS" if PlayerData.level == 4 else ("Level " + str(PlayerData.level + 1))
	%level_description_label.text = Utils.levels[PlayerData.level]["description"]
	%score_to_beat_label.text = "Score to beat: " + str(Utils.levels[PlayerData.level]["score_to_beat"])
	var tween = create_tween()
	tween.tween_property(%info_panel, "position:y", 97, 2.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
