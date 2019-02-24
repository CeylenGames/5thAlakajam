extends Node

var WaveNumber = 1
var Score = 0

export (NodePath) var Enemies
export (NodePath) var WaveLabel
export (NodePath) var WaveButton

export (Array) var spawners

export (NodePath) var EnemyContainer

var enemiesNb = 3 * WaveNumber
var max_enemies = enemiesNb

func _ready():
	get_node(WaveButton).hide()
	get_node(WaveButton).disabled = true
	update_ui()
	reset()

func update_ui():
	get_node(Enemies).set_text(str(enemiesNb) + "/" + str(max_enemies) + " enemies")
	get_node(WaveLabel).set_text("Wave : " + str(WaveNumber))

func reset():
	for spawner in spawners:
		get_node(spawner).reset(WaveNumber)

func _on_wave_ended():
	WaveNumber += 1
	enemiesNb = 3 * WaveNumber
	max_enemies = enemiesNb
	if WaveNumber % 1 == 0:
		$CheckPoint.power_on()
		get_node(WaveButton).disabled = false
		get_node(WaveButton).show()
		yield(get_node(WaveButton), "pressed")
		get_node(WaveButton).disabled = true
		get_node(WaveButton).hide()
		$CheckPoint.power_off()
	update_ui()
	reset()

func enemy_died():
	enemiesNb -= 1
	update_ui()
