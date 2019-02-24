extends Node

var WaveNumber = 1
var Score = 0

export (NodePath) var Enemies
export (NodePath) var WaveLabel

export (Array) var spawners

export (NodePath) var EnemyContainer

var enemiesNb = 3 * WaveNumber

func _ready():
	update_ui()
	reset()

func update_ui():
	get_node(Enemies).set_text(str(enemiesNb) + " enemies remaining")
	get_node(WaveLabel).set_text("Wave : " + str(WaveNumber))

func reset():
	for spawner in spawners:
		get_node(spawner).reset(WaveNumber)

func _on_wave_ended():
	WaveNumber += 1
	enemiesNb = 3 * WaveNumber
	update_ui()
	reset()

func enemy_died():
	enemiesNb -= 1
	update_ui()
