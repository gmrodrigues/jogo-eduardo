extends CharacterBody2D

@export var speed: float = 350.0
@export var attack_damage: int = 10
@export var attack_interval: float = 0.75

var target: CharacterBody2D
var attack_cooldown: float = 0.0

func _ready() -> void:
	var player_node: Node = get_tree().get_first_node_in_group("player")
	if player_node is CharacterBody2D:
		target = player_node

func _physics_process(delta: float) -> void:
	if not is_instance_valid(target):
		velocity = Vector2.ZERO
		return

	attack_cooldown = maxf(attack_cooldown - delta, 0.0)
	velocity = global_position.direction_to(target.global_position) * speed
	move_and_slide()

	if global_position.distance_to(target.global_position) < 190.0 and attack_cooldown <= 0.0:
		if target.has_method("take_damage"):
			target.call("take_damage", attack_damage)
		attack_cooldown = attack_interval

func die() -> void:
	queue_free()
