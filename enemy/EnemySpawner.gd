extends Marker2D
@export var enemy_scenes :Array[PackedScene] = []
@export var min_spawn_time :float = 0
@export var max_spawn_time :float = 1
signal enemy_dead()

func _ready() -> void:
	spawn_enemy()

func spawn_enemy():
	var new_enemy_scene = enemy_scenes.pick_random()
	var new_enemy = new_enemy_scene.instantiate()
	new_enemy.died.connect(new_died)
	add_child(new_enemy)
	get_tree().create_timer(randf_range(min_spawn_time, max_spawn_time)).timeout.connect(spawn_enemy)

func after_game_over():
	queue_free()

func new_died():
	enemy_dead.emit()
# 有僵尸死了先告诉生成器，再告诉主节点
