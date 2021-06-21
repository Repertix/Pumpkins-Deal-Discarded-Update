extends Node2D

func _ready():
	$Lol/RichTextLabel3.visible = false
	print("Ha! Got pranked. Lol. If you see this, take care of the code, lmao. AND Send a screenshot to the dev, of course, me. Lol.")

func _process(delta):
	$Just/A/Prank.motion_offset.x -= 0.5
	$Just/A/Prank.motion_offset.y -= 0.5

func _input(event):
	if Input.is_action_just_pressed("enter"):
		$Lol/RichTextLabel3.visible = true
		$Transition._goTo("res://scenes/Results.tscn")
