extends Sprite

export (Texture) var ComputerOn
export (Texture) var ComputerOff

var player_here = false
var powered = false

var bar_lvl
var lvl_golds = 10

func _ready():
	power_on()

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
	get_parent().get_node("GUI").show_shop()

func buy_bar():
	if get_parent().get_node("Player").coins >= lvl_golds:
		bar_lvl += 1
		get_parent().get_node("Player").bar_lvl = bar_lvl
		get_parent().get_node("Player").coins -= lvl_golds
		lvl_golds = bar_lvl * 10
		get_parent().get_node("Player").charge_max += 10 * bar_lvl
		get_node(get_parent().get_node("Player").ChargeBar).max_value = get_parent().get_node("Player").charge_max
	
	get_parent().get_node("Player").save_data()
func recharge():
	get_parent().get_node("Player").charge = get_parent().get_node("Player").charge_max
	get_parent().get_node("Player").save_data()