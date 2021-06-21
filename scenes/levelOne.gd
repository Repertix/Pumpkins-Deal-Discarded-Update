extends Node2D
var trucks = 0
signal _callUI(type)
func _ready():
	GameManager.recentMap = "res://scenes/City.tscn"

func _secondLess():
	if trucks == 120:
		get_parent().emit_signal("statsUpdate","truck","going",true)
		emit_signal("_callUI", "truck")
		trucks = 0

func _callTruck():
	get_parent().emit_signal("statsUpdate", "truck","going", true)
	emit_signal("_callUI", "truck")
	trucks = 0

func _restartContainers():
	get_parent().emit_signal("statsUpdate", "Container", "close", "lololol")

func _checkRound():
	var player = get_parent().get_node("Level/EntireLevel/AliveThings/Player")
	get_parent().emit_signal("statsUpdate", "Doors", "candies", int((player.maxCandies - (player.maxCandies * .99))))
	get_parent().emit_signal("statsUpdate", "Container", "candies", int((player.maxCandies - (player.maxCandies * .98))))


func _secondCD():
	trucks += 1
	if trucks == 120:
		get_parent().emit_signal("statsUpdate","truck","going",true)
		emit_signal("_callUI", "truck")
		trucks = 0
	pass # Replace with function body.
