extends Node

class_name GameController

@onready var remaining_runes = PlayerData.rune_bag.duplicate()
static var game_running = true
static var first_spell_played = false

@onready var play_slots = [
	%HandSlot,
	%HandSlot2,
	%HandSlot3,
	%HandSlot4,
	%HandSlot5
]

@onready var discard_slots = [
	%DiscardSlot,
	%DiscardSlot2
]

@onready var hand_slots = [
	%BagSlot, %BagSlot2, %BagSlot3, %BagSlot4, %BagSlot5, %BagSlot6, %BagSlot7
]

@onready var slot_particles = [
	%SpellSlotParticles,
	%SpellSlotParticles2,
	%SpellSlotParticles3,
	%SpellSlotParticles4,
	%SpellSlotParticles5
]

# indices of neighbors for each slot
const neighbors = [[2, 3], [3, 4], [4, 0], [0, 1], [1, 2]]

var current_score : int = 0
var current_mult : int = 0
var total_score : int = 0
var score_to_beat : int = 500
var plays : int = 3
var discards : int = 3
var essence_indicator

func reset(stb):
	remaining_runes = PlayerData.rune_bag
	current_score = 0
	current_mult = 0
	total_score = 0
	score_to_beat = stb
	plays = 3 + PlayerData.upgrades["pair_of_gloves"]
	discards = 3 + PlayerData.upgrades["vanishing_dust"]
	%target_label.text = str(score_to_beat)
	%casts_remaining_label.text = str(plays)
	%discards_remaining_label.text = "discards remaining: " + str(discards)
	# this is so lazy lol, need to figure out how to do this better
	%black_fadein.visible = true
	game_running = true
	essence_indicator = null
	first_spell_played = false

func display_combo(indices, combo):
	var combo_name = combo[0]
	await get_tree().create_timer(0.5).timeout
	for i in indices:
		slot_particles[i].restart()
	%ComboPlayed.text = Utils.combo_names[combo_name]
	%ComboPlayed.visible = true
	current_score += PlayerData.combo_scores[combo_name][0]
	current_mult += PlayerData.combo_scores[combo_name][1]
	# check for upgrades
	for element in Utils.element_names:
		print("checking element ", element)
		var catalyst_name = element + "_catalyst"
		print(catalyst_name)
		print(combo[1])
		if element.to_upper() in combo[1]:
			current_mult += PlayerData.upgrades[catalyst_name]
			
	for element in Utils.element_names:
		print("checking element ", element)
		var gem_name = element + "_gem"
		print(gem_name)
		print(combo[1])
		print(Utils.element_opposites[element])
		if element.to_upper() in combo[1]:
			print("present")
			current_mult += PlayerData.upgrades[gem_name] * 2
		if Utils.element_opposites[element].to_upper() in combo[1]:
			print("opposite present")
			current_mult -= PlayerData.upgrades[gem_name]
			
	if combo_name == "shape_triad":
		current_mult += PlayerData.upgrades["triad_booster"]
		
	%charge_label.text = str(current_score)
	%mult_label.text = str(current_mult)
	%current_spell_score_label.text = "+" + str(int(current_score * current_mult))
	await get_tree().create_timer(1.5).timeout
	%ComboPlayed.visible = false

func _ready():
	print(game_running)

func score_hand():
	current_score = 0
	current_mult = 0
	
	var combo_occurrences = {
		# elements
		"single_element" : [],
		"double_element" : [],
		"triple_element" : [],
		"quad_element" : [],
		"elemental_harmony" : [],
		# shapes
		"single_shape" : [],
		"double_shape" : [],
		"triple_shape" : [],
		"quad_shape" : [],
		"shape_harmony" : [],
		# all same shape and element
		"total_harmony" : [],
		# one of each shape
		"shape_triad" : [],
		# infusions
		"stable_infusions" : [],
		"unstable_infusions": []
	}
	
	# check element combos, will use dummy dict values to represent a set
	var runes_checked_for_elements = {}
	for i in range(5):
		#print("checking rune %d" % i)
		if runes_checked_for_elements.has(i): continue
		#print("rune %d not checked yet" % i)
		
		var rune = play_slots[i].rune
		
		if rune != null:
			#print("rune %d not null" % i)
			var connected = 1
			var runes_in_element_combo = [i]
			# check the neighbors
			for neighbor in range(2):
				var neighbor_index = neighbors[i][neighbor]
				var neighbor_rune = play_slots[neighbor_index].rune
				#print("neighbor index is %d" % neighbor_index)
				if neighbor_rune != null and neighbor_rune.element == rune.element and not runes_checked_for_elements.has(neighbor_index):
					#print("match between %d and %d" % [i, neighbor_index])
					runes_checked_for_elements[neighbor_index] = null
					runes_in_element_combo.append(neighbor_index)
					connected += 1
					
					# check for connections from neighbors
					var other_neighbor_index = neighbors[neighbor_index][0] if neighbors[neighbor_index][1] == i else neighbors[neighbor_index][1]
					var other_neighbor_rune = play_slots[other_neighbor_index].rune
					#print("neighbor index is %d" % neighbor_index)
					if other_neighbor_rune != null and other_neighbor_rune.element == neighbor_rune.element and not runes_checked_for_elements.has(other_neighbor_index):
						#print("match between %d and %d" % [neighbor_index, other_neighbor_index])
						connected += 1
						runes_checked_for_elements[other_neighbor_index] = null
						runes_in_element_combo.append(other_neighbor_index)
						
						# then check for connections from neighbor's neighbor
						var other_other_neighbor_index = neighbors[other_neighbor_index][0] if neighbors[other_neighbor_index][1] == neighbor_index else neighbors[other_neighbor_index][1]
						var other_other_neighbor_rune = play_slots[other_other_neighbor_index].rune
						if other_other_neighbor_rune != null and other_other_neighbor_rune.element == other_neighbor_rune.element and not runes_checked_for_elements.has(other_other_neighbor_index):
							#print("match between %d and %d" % [neighbor_index, other_neighbor_index])
							connected += 1
							runes_checked_for_elements[other_other_neighbor_index] = null
							runes_in_element_combo.append(other_other_neighbor_index)
			
			#print("connected %d" % connected)
			if connected == 1:
				combo_occurrences["single_element"].append([runes_in_element_combo, rune.element])
			elif connected == 2:
				combo_occurrences["double_element"].append([runes_in_element_combo, rune.element])
			elif connected == 3:
				combo_occurrences["triple_element"].append([runes_in_element_combo, rune.element])
			elif connected == 4:
				combo_occurrences["quad_element"].append([runes_in_element_combo, rune.element])
			elif connected == 5:
				combo_occurrences["elemental_harmony"].append([runes_in_element_combo, rune.element])
				break
		runes_checked_for_elements[i] = null
		
	# check shape combos, will use dummy dict values to represent a set
	var runes_checked_for_shapes = {}
	for i in range(5):
		#print("checking rune %d" % i)
		if runes_checked_for_shapes.has(i): continue
		#print("rune %d not checked yet" % i)
		
		var rune = play_slots[i].rune
		
		if rune != null:
			#print("rune %d not null" % i)
			var connected = 1
			var runes_in_shape_combo = [i]
			# check the neighbors
			for neighbor in range(2):
				var neighbor_index = neighbors[i][neighbor]
				var neighbor_rune = play_slots[neighbor_index].rune
				#print("neighbor index is %d" % neighbor_index)
				if neighbor_rune != null and neighbor_rune.shape == rune.shape and not runes_checked_for_shapes.has(neighbor_index):
					#print("match between %d and %d" % [i, neighbor_index])
					runes_checked_for_shapes[neighbor_index] = null
					runes_in_shape_combo.append(neighbor_index)
					connected += 1
					
					# check for connections from neighbors
					var other_neighbor_index = neighbors[neighbor_index][0] if neighbors[neighbor_index][1] == i else neighbors[neighbor_index][1]
					var other_neighbor_rune = play_slots[other_neighbor_index].rune
					#print("neighbor index is %d" % neighbor_index)
					if other_neighbor_rune != null and other_neighbor_rune.shape == neighbor_rune.shape and not runes_checked_for_shapes.has(other_neighbor_index):
						#print("match between %d and %d" % [neighbor_index, other_neighbor_index])
						connected += 1
						runes_checked_for_shapes[other_neighbor_index] = null
						runes_in_shape_combo.append(other_neighbor_index)
						
						# then check for connections from neighbor's neighbor
						var other_other_neighbor_index = neighbors[other_neighbor_index][0] if neighbors[other_neighbor_index][1] == neighbor_index else neighbors[other_neighbor_index][1]
						var other_other_neighbor_rune = play_slots[other_other_neighbor_index].rune
						if other_other_neighbor_rune != null and other_other_neighbor_rune.shape == other_neighbor_rune.shape and not runes_checked_for_shapes.has(other_other_neighbor_index):
							#print("match between %d and %d" % [neighbor_index, other_neighbor_index])
							connected += 1
							runes_checked_for_shapes[other_other_neighbor_index] = null
							runes_in_shape_combo.append(other_other_neighbor_index)
			
			#print("connected %d" % connected)
			if connected == 1:
				combo_occurrences["single_shape"].append([runes_in_shape_combo, rune.shape])
			elif connected == 2:
				combo_occurrences["double_shape"].append([runes_in_shape_combo, rune.shape])
			elif connected == 3:
				combo_occurrences["triple_shape"].append([runes_in_shape_combo, rune.shape])
			elif connected == 4:
				combo_occurrences["quad_shape"].append([runes_in_shape_combo, rune.shape])
			elif connected == 5:
				combo_occurrences["shape_harmony"].append([runes_in_shape_combo, rune.shape])
				break
		runes_checked_for_shapes[i] = null
	
	for i in range(5):
		if play_slots[i].rune == null or play_slots[neighbors[i][0]].rune == null or play_slots[neighbors[i][1]].rune == null:
			continue
		if play_slots[i].rune.shape != play_slots[neighbors[i][0]].rune.shape \
		and play_slots[neighbors[i][0]].rune.shape != play_slots[neighbors[i][1]].rune.shape \
		and play_slots[neighbors[i][1]].rune.shape != play_slots[i].rune.shape:
			combo_occurrences["shape_triad"].append([[i, neighbors[i][0], neighbors[i][1]], []])
	
	print(runes_checked_for_elements)
	print(runes_checked_for_shapes)
	print(combo_occurrences)
	
	%current_spell_score_label.text = ""
	%current_spell_score_label.visible = true
	
	if combo_occurrences["triple_element"].size() == 1 and combo_occurrences["double_element"].size() == 1:
		var runes_in_infusion = combo_occurrences["triple_element"][0][0]
		runes_in_infusion.append_array(combo_occurrences["double_element"][0][0])
		await display_combo(runes_in_infusion, ["unstable_infusion", [combo_occurrences["triple_element"][0][1], combo_occurrences["double_element"][0][1]]])
		combo_occurrences["triple_element"] = []
		combo_occurrences["double_element"] = []
		
	if combo_occurrences["shape_harmony"].size() == 1 and combo_occurrences["elemental_harmony"].size() == 1:
		await display_combo([0, 1, 2, 3, 4], ["total_harmony", [combo_occurrences["elemental_harmony"][0][1]]])
		combo_occurrences["shape_harmony"] = []
		combo_occurrences["elemental_harmony"] = []
		
	if combo_occurrences["double_element"].size() == 2:
		var runes_in_infusion = combo_occurrences["double_element"][0][0]
		runes_in_infusion.append_array(combo_occurrences["double_element"][1][0])
		await display_combo(runes_in_infusion, ["stable_infusion", [combo_occurrences["double_element"][0][1], combo_occurrences["double_element"][1][1]]])
		combo_occurrences["double_element"] = []
		
	for combo in combo_occurrences.keys():
		#print(combo)
		if combo == "single_element" or combo == "single_shape": continue
		if combo_occurrences[combo].size() == 0: continue
		#print("we have some of combo %s" % combo)
		
		for i in range(combo_occurrences[combo].size()):
			#print("calling display for combo %s" % combo)
			await display_combo(combo_occurrences[combo][i][0], [combo, [combo_occurrences[combo][i][1]]])
	
	if not first_spell_played:
		current_mult += PlayerData.upgrades["running_shoes"] * 2
	
	var number_of_runes_in_spell = 0
	for i in range(5):
		if play_slots[i].rune != null:
			number_of_runes_in_spell += 1
		
	if number_of_runes_in_spell <= 3:
		current_mult += PlayerData.upgrades["minimalism"] * 2
	
	total_score += current_score * current_mult
	%score_label.text = str(total_score)
	%current_spell_score_label.visible = false
	%charge_label.text = "0"
	%mult_label.text = "0"

func drawRune():
	if remaining_runes.size() == 0: return null
	
	var index = range(remaining_runes.size()).pick_random()
	return remaining_runes.pop_at(index)

func spell_exists():
	for i in range(5):
		if play_slots[i].rune != null:
			return true
		
	return false

func draw_new_runes():
	var empty_indices = []
	
	for i in range(Utils.HAND_SLOTS):
		var slot = %VBoxContainer.get_child(i).get_child(0)
		if slot.rune == null:
			empty_indices.append(i)
	
	if empty_indices.size() == 0 or remaining_runes.size() == 0: return
	
	%RuneDrawSFX.play()
	for i in empty_indices:
		var rune = drawRune()
		if rune == null: break
		var slot = %VBoxContainer.get_child(i).get_child(0)
		slot.rune = rune
		var rune_sprite = RuneSprite.new(rune)
		slot.add_child(rune_sprite)
		rune_sprite.position = Vector2(16, 16)

func create_extra_essence_indicator(number, reason):
	var indicator = load("res://sprites/extra_essence_indicator.tscn").instantiate()
	indicator.text = "+" + str(number) + " (" + reason + ")"
	indicator.set_position(Vector2(185, 82))
	print("adding to tree")
	%round_win_screen.add_child(indicator)
	var earned = int(%essence_earned_label.text)
	earned += number
	PlayerData.essence += number
	%essence_earned_label.text = str(earned)
	%EssenceIndicator.get_label().text = str(PlayerData.essence)
	await get_tree().create_timer(1.0).timeout

func win():
	if PlayerData.level == 4:
		get_tree().change_scene_to_file("res://sprites/final_win_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://sprites/upgrade_screen.tscn")
	
func lose():
	var tween = create_tween()
	tween.tween_property(%round_win_screen, "position:y", 110, 1.0).set_ease(Tween.EASE_IN)

func _on_play_spell_button_pressed():
	if not game_running: return
	if not spell_exists(): return
	await score_hand()
	
	plays -= 1
	%casts_remaining_label.text = str(plays)
	first_spell_played = true
	
	for i in range(5):
		var slot = play_slots[i]
		if slot.rune != null:
			slot.get_child(0).queue_free()
			slot.rune = null
			
	if total_score >= score_to_beat:
		game_running = false
		var audio_tween = create_tween()
		audio_tween.tween_property(%BackgroundMusic, "volume_db", -40.0, 2.0)
		var tween = create_tween()
		tween.tween_property(%black_fadein, "self_modulate:a", 1.0, 1.0).set_ease(Tween.EASE_IN)
		tween.tween_callback(win)
		return
	
	if plays == 0:
		game_running = false
		var tween = create_tween()
		tween.tween_property(%black_fadein, "self_modulate:a", 1.0, 1.0).set_ease(Tween.EASE_IN)
		tween.tween_callback(lose)
		return
	
	draw_new_runes()

func _on_discard_button_pressed():
	if discards == 0: return
	if not game_running: return
	for i in range(2):
		if discard_slots[i].rune == null:
			continue
		for hand_slot in range(7):
			if hand_slots[hand_slot].rune == null:
				var rune = drawRune()
				if rune == null: break
				hand_slots[hand_slot].rune = rune
				var rune_sprite = RuneSprite.new(rune)
				print("adding child")
				hand_slots[hand_slot].add_child(rune_sprite)
				rune_sprite.position = Vector2(16, 16)
				break
		discard_slots[i].rune = null
		discard_slots[i].get_child(0).queue_free()
	discards -= 1
	%discards_remaining_label.text = "discards remaining: " + str(discards)
	%DiscardSFX.play()
