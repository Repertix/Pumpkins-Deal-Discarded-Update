extends CanvasLayer

func _ready():
	$AnimationPlayer.play("fadeOff")

func _input(event):
	if Input.is_action_just_pressed("enter"):
		$Transition._goTo("res://scenes/mainMenu.tscn")
		$AudioStreamPlayer.play()
