extends CharacterBody2D
class_name Player

@export var move_speed:float = 400.0
@onready var sprite_2d: Node2D = $Sprite2D
@export var NowBullet: PackedScene
@onready var shoot_pos_right: Marker2D = %ShootPosRight
@onready var shoot_timer: Timer = $ShootTimer
@export var PlayerInput :Array[String] = []
@export var shoot_gap_time :float = 0.1

func _ready() -> void:
	shoot_timer.wait_time = shoot_gap_time

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector(PlayerInput[0], PlayerInput[1], PlayerInput[2],PlayerInput[3]).normalized()

	if direction:
		position += direction * move_speed * delta
	else:
		velocity = Vector2.ZERO

	if Input.is_action_pressed(PlayerInput[4]) and shoot_timer.time_left == 0:	# 检测是否按下射击
		shoot()
		shoot_timer.start()
	# 移动玩家
	move_and_slide() 

func shoot():
	var new_bullet = NowBullet.instantiate()	# 生成子弹实例
	new_bullet.direction = sprite_2d.scale.x	# 设置子弹朝向
	new_bullet.global_position = shoot_pos_right.global_position
	get_parent().add_child(new_bullet)	# 加入场景树

func set_now_bullet(NewBullet):
	NowBullet = NewBullet
