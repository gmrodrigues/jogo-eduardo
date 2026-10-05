extends Node2D

const ENEMY_SCENE: PackedScene = preload("res://enemy/enemy.tscn")

@export var maximum_enemies: int = 20
var spawn_points: Array[Marker2D] = []

func _ready() -> void:
	randomize()
	for child: Node in get_children():
		if child is Marker2D:
			spawn_points.append(child)

func _on_timer_timeout() -> void:
	if spawn_points.is_empty():
		return
	if get_tree().get_nodes_in_group("enemies").size() >= maximum_enemies:
		return

	var spawn_index: int = randi_range(0, spawn_points.size() - 1)
	var spawn_point: Marker2D = spawn_points[spawn_index]
	var enemy_instance: CharacterBody2D = ENEMY_SCENE.instantiate() as CharacterBody2D
	get_parent().add_child(enemy_instance)
	enemy_instance.global_position = spawn_point.global_position
