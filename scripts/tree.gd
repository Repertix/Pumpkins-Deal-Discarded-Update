extends StaticBody2D


export var style = 0

func _ready():
	$Sprite.set_frame(style)
