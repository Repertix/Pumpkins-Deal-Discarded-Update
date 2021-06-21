extends Node2D
var trucks = 0
signal _callUI(type)
func _ready():
	GameManager.recentMap = "res://scenes/School.tscn"

func _secondLess():
	pass

func _checkRound():
	var player = get_parent().get_node("Level/EntireLevel/AliveThings/Player")
	pass
