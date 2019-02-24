extends Node2D

func _on_Recharge_pressed():
	get_node("../../../CheckPoint").recharge()


func _on_Capacity_pressed():
	get_node("../../../CheckPoint").buy_bar()
