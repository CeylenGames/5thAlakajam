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

func _process(delta):
	if get_node(EnemyContainer).get_child_count() == 0:
		WaveNumber += 1
		reset()

func reset():
	for spawner in spawners:
		get_node(spawner).reset(WaveNumber)