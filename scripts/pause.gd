extends CanvasLayer
var pausable = false
var pause = false
var option = 0

func _input(event):
	if pausable:
		if Input.is_action_just_pressed("enter"):
			if pause:
				pause = false
			else:
				pause = true
			_checkPause()
			_checkOption()
	
	if pause:
		if Input.is_action_just_pressed("down"):
			if option >= 2:
				option = 0
			else:
				option += 1
		elif Input.is_action_just_pressed("up"):
			if option <= 0:
				option = 2
			else:
				option -= 1
		
		if Input.is_action_just_pressed("interact"):
			_confirmOption()
		
		_checkOption()

func _confirmOption():
	match option:
		0:
			pause = false
			_checkPause()
		1:
			get_parent().get_node("Transition")._goTo(str(get_tree().current_scene.filename))
		2:
			get_parent().get_node("Transition")._goTo("res://scenes/mainMenu.tscn")

func _ready():
	pause = false
	_checkPause()

func _checkOption():
	match option:
		0:
			$Texts/Resume.rect_position.x = 18
			$Texts/Restart.rect_position.x = 8
			$Texts/Exit.rect_position.x = 8
		1:
			$Texts/Restart.rect_position.x = 18
			$Texts/Exit.rect_position.x = 8
			$Texts/Resume.rect_position.x = 8
		2:
			$Texts/Exit.rect_position.x = 18
			$Texts/Restart.rect_position.x = 8
			$Texts/Resume.rect_position.x = 8

func _checkPause():
	match pause:
		true:
			$Texts/Paused.rect_position.x = -320
			$Texts/Resume.rect_position.x = -312
			$Texts/Restart.rect_position.x = -312
			$Texts/Exit.rect_position.x = -312
			$AnimationPlayer.play("pauseStart")
			$Panel.visible = true
			$Texts.visible = true
			get_tree().paused = true
		false:
			$AnimationPlayer.stop()
			$Texts/Paused.rect_position.x = -320
			$Texts/Resume.rect_position.x = -312
			$Texts/Restart.rect_position.x = -312
			$Texts/Exit.rect_position.x = -312
			$Panel.visible = false
			$Texts.visible = false
			get_tree().paused = false
