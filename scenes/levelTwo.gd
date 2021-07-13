extends Node2D
var trucks = 0
signal _callUI(type)
#Funny fact: For sprites, I had to play a duplicated version of Yandere Simulator, to get some references from Japanese school
#Another funny fact: Roblox uses a lot the GPU, and I amazed how it works more smooth that the original Yandere Simulator
#You're rlly dumb, Alex.
func _ready():
	GameManager.recentMap = "res://scenes/School.tscn"

func _secondLess():
	pass

func _checkRound():
	var player = get_parent().get_node("Level/EntireLevel/AliveThings/Player")
	pass
