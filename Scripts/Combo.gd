extends Node

export (Texture) var Button0
export (Texture) var Button1

export (PoolIntArray) var combo
var index = 0
var is_combo_finished = false

export (Color) var Green
export (Color) var Red
export (Color) var White

func _ready():
	update_ui()

func _process(delta):
	if not is_combo_finished:
		get_events()

func get_events():
	if Input.is_action_just_pressed("combo_0"):
		$Exit_Timer.stop()
		if combo[index] == 0:
			$TextureRect.modulate = Green
			$Accept_Timer.start()
		else:
			$TextureRect.modulate = Red
			$Reject_Timer.start()
			
	elif Input.is_action_just_pressed("combo_1"):
		$Exit_Timer.stop()
		if combo[index] == 1:
			$TextureRect.modulate = Green
			$Accept_Timer.start()
		else:
			$TextureRect.modulate = Red
			$Reject_Timer.start()
	else:
		$Exit_Timer.start()

func combo_exit():
	index = 0

func update_ui():
	if combo[index] == 0:
		$TextureRect.texture = Button0
	else:
		$TextureRect.texture = Button1

func change_index():
	index += 1
	if index == combo.size():
		$TextureRect.visible = false
		is_combo_finished = true
	else:
		normal_color()
		update_ui()

func normal_color():
	$TextureRect.modulate = White
