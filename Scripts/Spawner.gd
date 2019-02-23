extends Node2D

export (NodePath) var nav
export (PackedScene) var Enemy
export (NodePath) var Player
export (NodePath) var EnemyContainer

func spawn_enemy():
	var enemy = Enemy.instance()
	enemy.position = position
	get_node(EnemyContainer).add_child(enemy)
	enemy.set_nav(get_node(nav), get_node(Player))