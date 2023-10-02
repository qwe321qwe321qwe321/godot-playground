# Name in Scene: Player
# node Type: Sprite
class_name Player
extends Sprite2D
signal onHealthChangedSignal

var check: int = 0
var playerHealth: int = 100

func _process(deltaTime):
	if check < 1:
		check = check + 1
		changeHealth(-100)

func changeHealth(value):
	playerHealth = playerHealth + value
	onHealthChangedSignal.emit(playerHealth)
