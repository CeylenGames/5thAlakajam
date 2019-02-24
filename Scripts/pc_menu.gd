extends Node2D

func _on_Recharge_pressed():
	get_node("../../../CheckPoint").recharge()
	get_node("../../../GUI").destroy_menu()


func _on_Capacity_pressed():
	get_node("../../../CheckPoint").buy_bar()
	$Capacity/Label.text = str(get_node("../../../CheckPoint").lvl_golds)
	get_node("../../../GUI").destroy_menu()
