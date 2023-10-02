# Name in Scene: Health
# node Type: Node2D
extends Node2D
signal gameOver
@onready var PlayerNode:Player = $Player1 as Player

func _ready():
	PlayerNode.onHealthChangedSignal.connect(doSomething)

func doSomething(playerHealth):
	print('We changed value of health to: ', playerHealth)
	PlayerNode.onHealthChangedSignal.disconnect(doSomething)
	gameOver.emit()
