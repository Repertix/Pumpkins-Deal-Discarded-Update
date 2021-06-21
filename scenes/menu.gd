extends CanvasLayer

var option = 0
var optionss = ["res://scenes/characterSelector.tscn", "res://scenes/mainMenu.tscn", 
"res://scenes/piracy.tscn", 0]

func _ready():
	_checkOption()
	$Control/AnimationPlayer.play("walkin")

func _process(delta):
	$ParallaxBackground/Sky.motion_offset.x -= 0.1
	$ParallaxBackground/TreeFar.motion_offset.x -= 5
	$ParallaxBackground/TreeFarFar.motion_offset.x -= 2.5
	$ParallaxBackground/TreeFarFarFar.motion_offset.x -= 1

func _input(event):
	if Input.is_action_just_pressed("down"):
		option += 1
	elif Input.is_action_just_pressed("up"):
		option -= 1
	
	if option > optionss.size()-1:
		option = 0
	elif option == -1:
		option = optionss.size()-1
	
	_checkOption()
	
	if Input.is_action_just_pressed("interact"):
		_confirm()

func _checkOption():
	_resetSel()
	match option:
		0:
			$Play.margin_left += 20
		1:
			$Credits.margin_left += 20
		2:
			$Controls.margin_left += 20
		3:
			$Exit.margin_left += 20

func _resetSel():
	$Play.margin_left = 800
	$Credits.margin_left = 800
	$Controls.margin_left = 800
	$Exit.margin_left = 800

func _confirm():
	if typeof(optionss[option]) == 4:
		$Transition._goTo(optionss[option])
	elif optionss[option] == 0:
		get_tree().quit()
