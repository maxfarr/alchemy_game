extends Node

func wait(seconds) -> void:
	await get_tree().create_timer(seconds).timeout
