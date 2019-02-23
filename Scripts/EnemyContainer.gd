extends Node2D

var in_wave = false

signal wave_ended

func _process(delta):
	if get_child_count() != 0:
		in_wave = true
	else:
		if in_wave:
			emit_signal("wave_ended")
			in_wave = false
