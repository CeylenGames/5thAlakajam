extends Node

var WaveNumber = 1
var Score = 0

export (NodePath) var ScoreLabel
export (NodePath) var WaveLabel

export (Array) var spawners

export (NodePath) var EnemyContainer

func _ready():
	update_ui()
	reset()

func update_ui():
	get_node(ScoreLabel).set_text("Score : " + str(Score))
	get_node(WaveLabel).set_text("Wave : " + str(WaveNumber))

func reset():
	for spawner in spawners:
		get_node(spawner).reset(WaveNumber)

func _on_wave_ended():
	WaveNumber += 1
	update_ui()
	reset()
