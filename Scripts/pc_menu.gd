extends Node2D

func _ready():
	var bar_lvl = get_node("../../../Player").bar_lvl
	$Capacity/Label.text = str(bar_lvl * 10)

func _on_Recharge_pressed():
	get_node("../../../CheckPoint").recharge()
	get_node("../../../GUI").destroy_menu()


func _on_Capacity_pressed():
	get_node("../../../CheckPoint").buy_bar()
	get_node("../../../GUI").destroy_menu()
