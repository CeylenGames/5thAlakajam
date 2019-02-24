extends Sprite

export (Texture) var ComputerOn
export (Texture) var ComputerOff

var player_here = false
var powered = false

var bar_lvl = 1
var bar_golds = 10

func _ready():
	power_off()

func power_on():
	texture = ComputerOn
	powered = true

func power_off():
	texture = ComputerOff
	powered = false

func _on_area_entered(body):
	if body.is_in_group("Player"):
		player_here = true

func _on_area_exited(body):
	if body.is_in_group("Player"):
		player_here = false
		
func _process(delta):
	if player_here and powered and Input.is_action_just_pressed("ui_accept"):
		show_ui()
		
func show_ui():
	print("shop")

func buy_bar(max_progress, golds):
	bar_lvl += 1
	golds -= bar_golds
	bar_golds *= 2
	max_progress += 10 * bar_lvl