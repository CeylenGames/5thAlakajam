extends Sprite

export (Texture) var ComputerOn
export (Texture) var ComputerOff

var player_here = false
var powered = false

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
