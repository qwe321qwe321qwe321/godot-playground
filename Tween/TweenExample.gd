extends Sprite2D


@onready var tween := create_tween()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# reset
	tween.tween_property(self, "scale", Vector2(1, 1), 0)
	tween.parallel().tween_property(self, "rotation", 0, 0)
	
	tween.tween_property(self, "position", Vector2(300, 0), 1).set_trans(Tween.TRANS_CUBIC).from_current()
	tween.tween_callback(print_position)
	tween.tween_property(self, "position", Vector2(300, 300), 1).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(print_position)
	tween.tween_property(self, "position", Vector2(0, 300), 1).set_trans(Tween.TRANS_QUAD)
	tween.tween_callback(print_position)
	tween.tween_property(self, "position", Vector2(0, 0), 1).set_trans(Tween.TRANS_EXPO)
	tween.tween_callback(print_position)
	tween.tween_property(self, "position", Vector2(300, 300), 1).set_trans(Tween.TRANS_EXPO)
	tween.tween_method(print_param, 0, 100, 0.1)
	# Bind the second argument to 987.
	tween.tween_method(print_param2.bind(987), 0, 100, 0.1)
	# Bind the first argument to 123.
	tween.tween_callback(print_param.bind(123))
	owner
	tween.tween_property(self, "rotation", deg_to_rad(360), 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(self, "scale", Vector2(2, 2), 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	# inifinite loop.
	tween.set_loops()

	# if you wanna play only once and replay again.	
	#tween.tween_callback(tween.stop)
	
	
func print_position() -> void:
	print("hello! I'm at %s" % str(position))

func print_param(param1: int) -> void:
	print("Hi %d" % [param1])
	
func print_param2(param1: int, param2: int) -> void:
	print("Hi %d and %d" % [param1, param2])
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		tween.play()
	
func play_tween() -> void:
	tween.play()
