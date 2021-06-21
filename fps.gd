extends RichTextLabel
onready var debug = false
onready var dbInf = get_parent().get_parent().get_parent()
func _ready():
	_checkDbg()

func _input(event):
	if Input.is_action_just_pressed("debug"):
		if debug:
			debug = false
		else:
			debug = true
		_checkDbg()

func _checkDbg():
	if debug:
		visible = true
	else:
		visible = false

func _process(delta):
	set_bbcode("FPS: "+str(Engine.get_frames_per_second())+"\nRounds: "+str(dbInf.currentRound)+"\nCharacter: "+str(dbInf.gman.character)+"\nMax Health: "+str(dbInf.get_node("Level/EntireLevel/AliveThings/Player").maxHealth)+"\nThe Game: The Game")
