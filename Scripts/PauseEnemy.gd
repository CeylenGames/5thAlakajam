extends CanvasLayer

export (PackedScene) var MenuToInstanciate

func show_menu():
	get_tree().paused = true
	var m = MenuToInstanciate.instance()
	add_child(m)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		#show_menu()
		print("menu")