extends StaticBody2D

func _ready():
	randomize()
	$Sprite.frame = randi()%3


