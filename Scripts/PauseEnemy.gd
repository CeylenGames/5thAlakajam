extends CanvasLayer

export (PackedScene) var PauseMenu
export (PackedScene) var ShopMenu

var menu_opened = false
var menu

func _ready():
	$TextureRect.hide()

func show_menu(menu_packed):
	get_tree().paused = true
	$TextureRect.show()
	menu = menu_packed.instance()
	$Control.add_child(menu)
	menu_opened = true

func destroy_menu():
	$TextureRect.hide()
	menu.queue_free()
	get_tree().paused = false

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if not menu_opened:
			show_menu(PauseMenu)