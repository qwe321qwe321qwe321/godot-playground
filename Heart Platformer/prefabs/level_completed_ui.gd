extends ColorRect
class_name LevelCompletedNode

signal on_pushed_retry
signal on_pushed_next_level

@onready var retry_button: Button = %RetryButton
@onready var next_level_button: Button = %NextLevelButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_retry_button_pressed() -> void:
	print("retry!")
	on_pushed_retry.emit()


func _on_next_level_button_pressed() -> void:
	print("next level!")
	on_pushed_next_level.emit()
