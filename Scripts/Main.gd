extends Node

var WaveNumber = 0
var Score = 0

export (Array) var spawners

func set_wave():
	for timer in spawners:
		get_node(timer).start()

func end_wave():
	for timer in spawners:
		get_node(timer).stop()