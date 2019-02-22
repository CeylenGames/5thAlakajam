extends Node

export (Texture) var Button0
export (Texture) var Button1

export (PoolIntArray) var combo
var index = 0
var is_combo_finished = false

func _ready():
	update_ui()

func _process(delta):
	if not is_combo_finished:
		get_events()

func get_events():
	if Input.is_action_just_pressed("combo_0"):
		$Timer.stop()
		if combo[index] == 0:
			update_ui()
			index += 1
			# Anim bon code
		# Sinon anim faux
	elif Input.is_action_just_pressed("combo_1"):
		$Timer.stop()
		if combo[index] == 1:
			index += 1
			update_ui()
			# Anim bon code
		#Sinon faux
	else:
		$Timer.start()

func combo_exit():
	index = 0

func update_ui():
	if combo[index] == 0:
		$TextureRect.texture = Button0
	else:
		$TextureRect.texture = Button1
