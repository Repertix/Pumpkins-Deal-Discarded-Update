extends CanvasLayer
onready var gman = get_node("/root/GameManager")
onready var character = 0
var actualSelect = 0
var map = 0
onready var charNames = ["Phynton", "Tankman", "T.A.S."]
onready var mapNames = ["Cavecall Residences", "Rogueborn Academy"]
onready var mapLol = ["res://scenes/City.tscn", "res://scenes/School.tscn"]
onready var option = 0 #0: Character / 1: Map
var speed = 1000
var velocity = Vector2()
#NO TRADUCIRÉ ESTO, USA TRADUCTOR.

#Let's talk a little bit about characters, this game was meant to have lots of references to NG
#But then I thought it was a stupid idea, even when I don't know much about NG, that would be
#Very stupid of my part and just a way to attract people to this not fun game, so for Hontento
#I decided to work around my mind, and not in others one, when we talk about some references and things
#Don't worry little Timmy, you will be able to play Hontento with your PS4 controller. Anyways
#There was the big plan of including tankman, but BRUH, I didn't liked the sprites, I can
#say cannoncally it wasn't tankman, just a kid disguised of him.

#About Boxing Jack, he was the first character to be implemented before the game plans were changed,
#the first idea I had I think it was even better then this...

#About T.A.S. this was a character I created time ago when made some concepts with Nitro, yeah, the Nitro
#one that it's a ghost and dissappeared suddenly from twitter(He's fine, btw.) I was planning to make
#a game about a robot escaping from a laboratory, taking inspiration from Undertale, but It was too much
#and in that time I felt uncomfortable with Game Maker Studio 2, even now, I don't want to touch it anymore.
#maybe someday this little buddy will have a game.

#About old version of Phynton, this was the first re-desing of it. But when Nidooze re-designed it, I liked
#more that desing and decided to use it, I technically did a re-desing after it, making him more tall and
#with a more Pumpkin-like head, (The original desing looked like a crossiant, oala!)
#In some point of development, there was meant to have a story, about the old desing and new being brothers
#and some shit related to the enemy of the first version of Pupmkin's Deal, but I decided to
#discard it.


func _ready():
	_checkChar()
	_checkMap()
	_checkSelect()

func _checkSelect():
	match actualSelect:
		0:
			$RichTextLabel2.set_bbcode("[center]Select a Character[/center]")
		1:
			$RichTextLabel2.set_bbcode("[center]Select a Map[/center]")
func _confirm():
	gman.character = character

func _input(delta):
	
	if Input.is_action_just_pressed("esc"):
		if actualSelect == 0:
			$Transition._goTo("res://scenes//mainMenu.tscn")
		elif actualSelect == 1:
			actualSelect -= 1
		_checkSelect()
	if Input.is_action_just_pressed("left"):
		if actualSelect == 0:
			if character <= 0:
				character = charNames.size()-1
			else:
				character -= 1
			_checkChar()
		elif actualSelect == 1:
			if map <= 0:
				map = mapNames.size()-1
			else:
				map -= 1
			_checkMap()
	elif Input.is_action_just_pressed("right"):
		if actualSelect == 0:
			if character >= charNames.size()-1:
				character = 0
			else:
				character += 1
			_checkChar()
		elif actualSelect == 1:
			if map >= mapNames.size()-1:
				map = 0
			else:
				map += 1
			_checkMap()
	
	if Input.is_action_just_pressed("interact"):
		if actualSelect == 0:
			actualSelect += 1
			_checkSelect()
		elif actualSelect == 1:
			$RichTextLabel2.set_bbcode("[center]Let's Go![/center]")
			_confirm()
			$Transition._goTo(mapLol[map])
		

func _checkMap():
	$Maprite.frame = map
	$MapName.set_bbcode("[center]"+mapNames[map]+"[/center]")

func _process(delta):
	$ParallaxBackground/ParallaxLayer.motion_offset.x += .5
	$ParallaxBackground/ParallaxLayer.motion_offset.y += .5

func _checkChar():
	$Charprite.frame = character
	$RichTextLabel.set_bbcode("[center]"+charNames[character]+"[/center]")
