extends Sprite

export (Texture) var Button0
export (Texture) var Button1
export (Texture) var ButtonEnter

var combo = PoolIntArray()
var index = 0
var is_ready = false
var afk = false
var animating = false

signal combo_ended

func begin(size):
	create_Bytes(size)
	update_ui()
	is_ready = true

func _process(delta):
	if is_ready and not animating:
		get_events()

func get_events():
	if Input.is_action_just_pressed("combo_0"):
		$Exit_Timer.stop()
		if combo[index] == 0:
			$AnimationPlayer.play("Accept")
			animating = true
			yield($AnimationPlayer, "animation_finished")
			change_index()
			animating = false
		else:
			$AnimationPlayer.play("Reject")
			animating = true
			yield($AnimationPlayer, "animation_finished")
			$AnimationPlayer.play("Idle")
			animating = false
			
	elif Input.is_action_just_pressed("combo_1"):
		$Exit_Timer.stop()
		if combo[index] == 1:
			$AnimationPlayer.play("Accept")
			animating = true
			yield($AnimationPlayer, "animation_finished")
			change_index()
			animating = false
		else:
			$AnimationPlayer.play("Reject")
			animating = true
			yield($AnimationPlayer, "animation_finished")
			$AnimationPlayer.play("Idle")
			animating = false
	elif Input.is_action_just_pressed("ui_accept"):
		$Exit_Timer.stop()
		if combo[index] == 2:
			if get_node("../../../Player").selected:
				$AnimationPlayer.play("Accept")
				animating = true
				yield($AnimationPlayer, "animation_finished")
				change_index()
				animating = false
			else:
				$AnimationPlayer.play("Reject")
				animating = true
				yield($AnimationPlayer, "animation_finished")
				$AnimationPlayer.play("Idle")
				animating = false
			
	else:
		if not afk:
			afk = true
			$Exit_Timer.start()

func combo_exit():
	$AnimationPlayer.play("End")
	yield($AnimationPlayer, "animation_finished")
	get_node("../../../Player").is_comboting = false
	queue_free()

func update_ui():
	if combo[index] == 0:
		texture = Button0
	elif combo[index] == 1:
		texture = Button1
	else:
		texture = ButtonEnter

func change_index():
	index += 1
	if index == combo.size():
		emit_signal("combo_ended")
		queue_free()
	else:
		$AnimationPlayer.play("Idle")
		update_ui()

func create_Bytes(size):
	var i = 0
	while i < size:
		combo.append(int(rand_range(0, 2)))
		i += 1
	combo.append(2)