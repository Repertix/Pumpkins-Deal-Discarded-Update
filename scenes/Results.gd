extends CanvasLayer
var conti = false

func _ready():
	var gman = get_node("/root/GameManager")
	$"Time Alive/Amount".set_bbcode(" "+str(gman.timeSurvived))
	$Rounds/Amount.set_bbcode(" "+str(gman.survivedRounds))
	$Candys/Amount.set_bbcode(" "+str(gman.obtainedCandies))

func _process(delta):
	$ParallaxBackground/ParallaxLayer.motion_offset.x += -.5
	$ParallaxBackground/ParallaxLayer.motion_offset.y += -.5

func _input(event):
	if conti:
		if Input.is_action_just_pressed("enter"):
			$Transition._goTo(GameManager.recentMap)
		
		if Input.is_action_just_pressed("esc"):
			$Transition._goTo("res://scenes/mainMenu.tscn")

func _start():
	$Timer.start()
	$AnimationPlayer.play("results")


func _on_Timer_timeout():
	conti = true
	$Timer.stop()
	pass # Replace with function body.
