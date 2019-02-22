extends Node

var is_comboting = false
export (Texture) var Button0
export (Texture) var Button1

export (PoolIntArray) var combo
var index = 0
var is_combo_finished = false

func _process(delta):
	if not is_combo_finished:
		get_events()

func get_events():
	if Input.is_action_just_pressed("combo_0"):
		if combo[index] == 0:
			index += 1
			# Anim bon code
		# Sinon anim faux
	elif Input.is_action_just_pressed("combo_1"):
		if combo[index] == 1:
			index += 1
			# Anim bon code
		#Sinon faux
	if index == seq.size():
		pass
		

func combo_exit():
	is_comboting = false
