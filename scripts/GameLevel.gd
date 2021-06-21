extends Node2D
onready var gman = get_node("/root/GameManager")
onready var bullyDam = 1
onready var time = 360
var char_data
onready var candyAument = 75
onready var currentRound = 0
onready var survivedTime = 1
onready var truck = 0
onready var timeStart = 3
onready var candyToGive = 25
onready var cTgAU = 37
onready var cnds = 0
onready var scsCnds = 20
onready var scs = 7
var events = 0
#onready var endingSoon = false
signal statsUpdate(element,stat,value)

func _nextRound():
	currentRound += 1
	_IorDTime(120)
	emit_signal("statsUpdate", "Player", "candieMax", candyAument)
	_checkRound()
	$HUD._changeHudInfo("maxCandies", get_node("Level/EntireLevel/AliveThings/Player").maxCandies, "penis")
	candyAument += 25

func _callForHelp(tof):
	if tof:
		emit_signal("statsUpdate", "Generator", "generateHearts", true)
	else:
		emit_signal("statsUpdate", "Generator", "generateHearts", false)


func _checkRound():
	$LevelResources._checkRound()


func _start():
	$ReadyTexts._callText()

func _ready():
	_checkCharacter()
	

func _input(event):
	if Input.is_action_just_pressed("originalChar"):
		_finishGame()
	
	if Input.is_action_just_pressed("generate"):
		$LevelResources.trucks = 119

func _checkCharacter():
	var chardata_file = File.new()
	chardata_file.open("res://misc/characters.json", File.READ)
	var char_json = JSON.parse(chardata_file.get_as_text())
	char_data = char_json.result
	$HUD.charSpr = char_data[str(gman.character)].iconLife
	var chara = load(char_data[str(gman.character)].character)
	var chr = chara.instance()
	chr.name = "Player"
	$Level/EntireLevel/AliveThings.add_child(chr)
	
func _IorDTime(seconds):
	if time > 0:
		time += seconds
		$HUD._changeHudInfo("time", str(time), "penis")

func _secondLess():
	survivedTime+=1
	truck += 1
	
	
	if time > 0:
		time-= 1
	
	if time == 0:
		_finishGame()
	pass # Replace with function body.



func _finishGame():
	randomize()
	var chances = randi()%1000+1
	print(chances)
	gman.obtainedCandies = get_node("Level/EntireLevel/AliveThings/Player").candy
	gman.survivedRounds = currentRound
	gman.timeSurvived = survivedTime
	if chances == 1:
		$Transition._goTo("res://scenes/piracy.tscn")
	else:
		$Transition._goTo("res://scenes/Results.tscn")
	get_tree().paused = true
	pass # Replace with function body.
