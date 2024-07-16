extends CharacterBody2D
class_name Bullet
@export var move_speed: float = 450.0
@onready var direction: float
@export var hurt: float = 10

func _physics_process(_delta: float) -> void:
	velocity.x = move_speed * direction
	var collition_count := get_slide_collision_count()
	for i in collition_count:
		var collider_info := get_slide_collision(i)
		var collider := collider_info.get_collider()
		if collider in get_tree().get_nodes_in_group("enemy") and collider.has_method("take_damage"):
			collider.take_damage(hurt)
			queue_free()
	move_and_slide()
