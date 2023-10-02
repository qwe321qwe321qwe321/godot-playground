extends Node2D

@export var next_level : PackedScene
@onready var level_completed: ColorRect = $CanvasLayer/LevelCompleted

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	Events.level_completed.connect(show_level_completed)
	
func show_level_completed():
	level_completed.show()
	if !next_level: 
		# end.
		get_tree().paused = true
		return
		
	# next level.
	get_tree().paused = true
	await LevelTransition.fade_to_black()
	get_tree().paused = false
	get_tree().change_scene_to_packed(next_level)
	LevelTransition.fade_from_black()
