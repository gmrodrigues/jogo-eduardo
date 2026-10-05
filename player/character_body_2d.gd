extends CharacterBody2D

signal health_changed(current_health: int, maximum_health: int)
signal died

@export var speed: float = 600.0
@export var maximum_health: int = 100

var health: int

func _ready() -> void:
	health = maximum_health
	health_changed.emit(health, maximum_health)

func get_input() -> void:
	var input_direction: Vector2 = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed

func _physics_process(_delta: float) -> void:
	get_input()
	move_and_slide()

func take_damage(amount: int) -> void:
	if health <= 0:
		return
	health = maxi(health - amount, 0)
	health_changed.emit(health, maximum_health)
	if health == 0:
		velocity = Vector2.ZERO
		set_physics_process(false)
		died.emit()
