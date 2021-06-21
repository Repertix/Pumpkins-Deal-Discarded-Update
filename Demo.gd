extends Node2D
onready var chara = $charac

func _input(event):
	
	var new_path = $Navigation2D.get_simple_path(chara.get_global_position(), $Navigation2D/StaticBody2D.global_position)
	$Line2D.points = new_path
	chara.path = new_path
	print(str(new_path))

