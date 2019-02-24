extends Node2D

func _on_Resume_pressed():
	print("marche")
	get_parent().get_parent().destroy_menu()


func _on_Quit_pressed():
	print("quit")
	get_tree().quit()


func _on_Options_pressed():
	pass # replace with function body
