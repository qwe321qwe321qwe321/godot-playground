extends Node2D

@export var next_level : PackedScene

@onready var level_completed: LevelCompletedNode = $CanvasLayer/LevelCompleted
@onready var start_in: ColorRect = %StartIn
@onready var start_counting_down_player: AnimationPlayer = $StartCountingDownPlayer
@onready var level_time_label: Label = %LevelTimeLabel

var current_level_time: float = 0
var start_level_msec: float = 0

func _ready() -> void:
	Events.level_completed.connect(show_level_completed)
	get_tree().paused = true
	start_in.visible = true
	await LevelTransition.fade_from_black()
	start_counting_down_player.play("count_down")
	await start_counting_down_player.animation_finished
	start_in.visible = false
	get_tree().paused = false
	start_level_msec = Time.get_ticks_msec()
	current_level_time = 0
	
func _process(delta: float) -> void:
	current_level_time += delta
	level_time_label.text = "%.3f" % current_level_time
	
	
func show_level_completed():
	level_completed.show()
	level_completed.retry_button.grab_focus()
	get_tree().paused = true

func go_to_next_level() -> void:
	# next level.
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	if next_level:
		get_tree().change_scene_to_packed(next_level)
	else:
		get_tree().change_scene_to_file("res://scenes/start_menu.tscn")
		await LevelTransition.fade_from_black()
		
func retry() -> void:
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	var current_level := load(scene_file_path) as PackedScene
	get_tree().change_scene_to_packed(current_level)
	
func _on_level_completed_on_pushed_next_level() -> void:
	go_to_next_level()

func _on_level_completed_on_pushed_retry() -> void:
	retry()
