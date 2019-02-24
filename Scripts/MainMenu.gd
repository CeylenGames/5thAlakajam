extends CanvasLayer

var tuto_image

func _ready():
	tuto_image = get_node("TextureRect2")

func play():
	get_tree().change_scene("res://World.tscn")
	
func _process(delta):
	if Input.is_action_just_pressed("tuto"):
		tuto_image.visible = not tuto_image.visible

func _on_quit_pressed():
	get_tree().quit()
