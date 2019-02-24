extends Node2D

export (NodePath) var nav
export (PackedScene) var Enemy
export (NodePath) var Player
export (NodePath) var EnemyContainer

export (Array) var sprites

export (float) var time_left

var counter = 0
var max_counter = 1

func spawn_enemy():
	var enemy = Enemy.instance()
	enemy.position = position
	get_node(EnemyContainer).add_child(enemy)
	enemy.set_sprite(sprites[rand_range(0, sprites.size())])
	enemy.set_nav(get_node(nav), get_node(Player))
	
	counter += 1
	if counter == max_counter:
		$Timer.stop()
	if counter == 1:
		$Timer.wait_time = 3
	
func reset(waveNumber):
	counter = 0
	max_counter = waveNumber
	$Timer.wait_time = time_left
	$Timer.start()