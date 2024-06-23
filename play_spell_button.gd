extends TextureButton

@onready var play_slots = [
	%HandSlot,
	%HandSlot2,
	%HandSlot3,
	%HandSlot4,
	%HandSlot5
]

# indices of neighbors for each slot
const neighbors = [[2, 3], [3, 4], [4, 0], [0, 1], [1, 2]]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func score_hand():
	var score = 0
	var mult = 0
	
	var combo_occurrences = {
		# element
		"single_element" : [],
		"double_element" : [],
		"triple_element" : [],
		"quad_element" : [],
		# all same element
		"pure_infusion" : [],
		#shapes
		"single_shape" : [],
		"double_shape" : [],
		"triple_shape" : [],
		"quad_shape" : [],
		# all same shape
		"balanced_infusion" : [],
		# all same shape and element
		"total_infusion" : []
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
					
					# ...and then check the neighbors of each neighbor
					# sorry to anyone reading this code in the future, had to make quick decisions
					for other_neighbor in range(2):
						var other_neighbor_index = neighbors[neighbor_index][other_neighbor]
						if other_neighbor_index == i: continue
						var other_neighbor_rune = play_slots[other_neighbor_index].rune
						#print("neighbor index is %d" % neighbor_index)
						if other_neighbor_rune != null and other_neighbor_rune.element == neighbor_rune.element and not runes_checked_for_elements.has(other_neighbor_index):
							#print("match between %d and %d" % [neighbor_index, other_neighbor_index])
							connected += 1
							runes_checked_for_elements[other_neighbor_index] = null
							runes_in_element_combo.append(other_neighbor_index)
			
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
				combo_occurrences["pure_infusion"].append([runes_in_element_combo, rune.element])
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
					
					# ...and then check the neighbors of each neighbor
					# sorry to anyone reading this code in the future, had to make quick decisions
					for other_neighbor in range(2):
						var other_neighbor_index = neighbors[neighbor_index][other_neighbor]
						if other_neighbor_index == i: continue
						var other_neighbor_rune = play_slots[other_neighbor_index].rune
						#print("neighbor index is %d" % neighbor_index)
						if other_neighbor_rune != null and other_neighbor_rune.shape == neighbor_rune.shape and not runes_checked_for_shapes.has(other_neighbor_index):
							#print("match between %d and %d" % [neighbor_index, other_neighbor_index])
							connected += 1
							runes_checked_for_shapes[other_neighbor_index] = null
							runes_in_shape_combo.append(other_neighbor_index)
			
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
				combo_occurrences["balanced_infusion"].append([runes_in_shape_combo, rune.shape])
				break
		runes_checked_for_shapes[i] = null
		
	print(runes_checked_for_elements)
	print(runes_checked_for_shapes)
	print(combo_occurrences)
	
	if combo_occurrences["triple_element"].size() == 1 and combo_occurrences["double_element"].size() == 1:
		pass
	
	return {"score" : score, "mult" : mult}

func _on_pressed():
	var score_values = score_hand()
