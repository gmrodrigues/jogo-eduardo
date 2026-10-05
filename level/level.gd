extends Node2D

@onready var player_node: CharacterBody2D = $player
@onready var health_bar: ProgressBar = $HUD/HealthBar
@onready var health_label: Label = $HUD/HealthLabel

func _ready() -> void:
	player_node.health_changed.connect(_on_health_changed)
	player_node.died.connect(_on_player_died)
	_on_health_changed(player_node.health, player_node.maximum_health)

func _on_health_changed(current_health: int, maximum_health: int) -> void:
	health_bar.max_value = maximum_health
	health_bar.value = current_health
	health_label.text = "VIDA  %d / %d" % [current_health, maximum_health]

func _on_player_died() -> void:
	health_label.text = "FIM DE JOGO"
	await get_tree().create_timer(1.5).timeout
	get_tree().reload_current_scene()
