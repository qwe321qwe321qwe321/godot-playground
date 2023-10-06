extends Node2D

@export var next_level : PackedScene
@onready var level_completed: ColorRect = $CanvasLayer/LevelCompleted
@onready var start_in: ColorRect = %StartIn
@onready var start_in_label: Label = %StartInLabel
@onready var start_counting_down_player: AnimationPlayer = $StartCountingDownPlayer

func _ready() -> void:
	Events.level_completed.connect(show_level_completed)
	get_tree().paused = true
	start_in.visible = true;
	await LevelTransition.fade_from_black()
	start_counting_down_player.play("count_down")
	await start_counting_down_player.animation_finished
	start_in.visible = false;
	get_tree().paused = false
	
func show_level_completed():
	level_completed.show()
	# next level.
	get_tree().paused = true
	await get_tree().create_timer(1.0).timeout
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	if next_level:
		get_tree().change_scene_to_packed(next_level)
	else:
		get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
		await LevelTransition.fade_from_black()
	
