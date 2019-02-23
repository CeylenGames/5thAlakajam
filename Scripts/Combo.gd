extends Node

export (Texture) var Button0
export (Texture) var Button1

var combo = PoolIntArray()
var index = 0
var is_ready = false
var afk = false

func begin(size):
	create_Bytes(size)
	update_ui()
	is_ready = true

func _process(delta):
	if is_ready:
		get_events()

func get_events():
	if Input.is_action_just_pressed("combo_0"):
		$Exit_Timer.stop()
		if combo[index] == 0:
			$AnimationPlayer.play("Accept")
			yield($AnimationPlayer, "animation_finished")
			change_index()
		else:
			$AnimationPlayer.play("Reject")
			yield($AnimationPlayer, "animation_finished")
			$AnimationPlayer.play("Idle")
			
	elif Input.is_action_just_pressed("combo_1"):
		$Exit_Timer.stop()
		if combo[index] == 1:
			$AnimationPlayer.play("Accept")
			yield($AnimationPlayer, "animation_finished")
			change_index()
		else:
			$AnimationPlayer.play("Reject")
			yield($AnimationPlayer, "animation_finished")
			$AnimationPlayer.play("Idle")
	else:
		if not afk:
			afk = true
			$Exit_Timer.start()

func combo_exit():
	$AnimationPlayer.play("End")
	yield($AnimationPlayer, "animation_finished")
	queue_free()

func update_ui():
	if combo[index] == 0:
		$TextureRect.texture = Button0
	else:
		$TextureRect.texture = Button1

func change_index():
	index += 1
	if index == combo.size():
		queue_free()
	else:
		$AnimationPlayer.play("Idle")
		update_ui()

func create_Bytes(size):
	var i = 0
	while i < size:
		combo.append(int(rand_range(0, 2)))
		i += 1