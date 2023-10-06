extends CenterContainer

@export var levelOne : PackedScene

@onready var start_game_button: Button = %StartGameButton

func _ready() -> void:
	RenderingServer.set_default_clear_color(Color.BLACK)
	start_game_button.grab_focus()


func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_packed(levelOne)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
