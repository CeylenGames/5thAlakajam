extends CanvasLayer

func play():
	get_tree().change_scene("res://World.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		play()
