extends Node2D

@export var house_health:float = 100
@export var enemy_hurt: float = 10
@onready var house_health_bar: ProgressBar = %HouseHealthBar
@onready var game_over_label: Label = $CanvasLayer/GameOverLabel
@export var scores: int = 0
@onready var score_label: Label = %ScoreLabel
@onready var player: Player = $Player
@onready var player_2: Player = $Player2
@export var BulletScenes: Array[PackedScene] = []
var bullet_idx :int = 0
var price_list := [10, 20, 30, 40, 50, 60, 70, 90, 120, 150, 200]

func _ready() -> void:
	house_health_bar.max_value = house_health
	house_health_bar.value = house_health

func _on_enemy_count_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		body.queue_free()
		house_health -= enemy_hurt
		house_health_bar.value = house_health
		if house_health <= 0:
			propagate_call("after_game_over")
			game_over_label.visible = true
			# 重新加载场景
			await get_tree().create_timer(3).timeout
			get_tree().reload_current_scene()

func count_scores():	# 有敌人死亡后统计加分
	scores += 1
	score_label.text = str(scores)
	if scores in price_list and bullet_idx < BulletScenes.size():
		player_2.set_now_bullet(BulletScenes[bullet_idx])
		player.set_now_bullet(BulletScenes[bullet_idx])
		bullet_idx += 1

