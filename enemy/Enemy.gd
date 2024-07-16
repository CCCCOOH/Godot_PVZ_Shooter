extends CharacterBody2D
@export var move_speed:float = 100.0
@export var health: float = 100.0
@onready var progress_bar: ProgressBar = $ProgressBar
signal died()

func _ready() -> void:
	progress_bar.max_value = health
	progress_bar.value = health

func _physics_process(delta: float) -> void:
	velocity.x = - move_speed
	move_and_slide()

func take_damage(hurt: int = 25):
	health -= hurt
	progress_bar.value = health
	if health <= 0:
		queue_free()
		died.emit()

func after_game_over():
	queue_free()
