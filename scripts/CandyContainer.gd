extends StaticBody2D
var option = 0
var alreadyUsed = false
var playerConnected = false
export(int, 0,2) var dir
var candyToGive = randi()%20
signal increaseCandies(amount)

func _ready():
	randomize()
	option = randi()%3
	_verifyDirection(dir)
	get_parent().get_parent().get_parent().get_parent().connect("statsUpdate", self, "_stats")

func _stats(element, stat, value):
	if element == "Container":
		match stat:
			"candies":
				candyToGive = randi()%value
			"close":
				randomize()
				if alreadyUsed:
					option = randi()%2
					alreadyUsed = false
					$AnimationPlayer.play("VertiClose")

func _verifyDirection(diree):
	match diree:
		0:
			$Sprite.frame = 0
			$VerticalCube.disabled = false
		1:
			$Sprite.frame = 5
			$HorizontalCube.disabled = false
		2:
			$Sprite.frame = 0
			$VerticalCube.disabled = false
			$Sprite.scale.x = -1
func _interact(player):
	if !alreadyUsed:
		if dir == 0 or dir == 2:
			match option:
				0:
					print("Nothing")
					$AnimationPlayer.play("VerticalEmpty")
					alreadyUsed = true
				1:
					randomize()
					print("Something")
					$AnimationPlayer.play("VerticalFull")
					player._changeCandies(candyToGive)
					alreadyUsed = true
					$AudioStreamPlayer.play()
				2:
					print("Boop Beep")
					$AnimationPlayer.play("VerticalBoop")
					player._changeCandies(5)
					alreadyUsed = true
					$AudioStreamPlayer.play()
		if dir == 1:
			match option:
				0:
					print("Nothing")
					$AnimationPlayer.play("HorizontalEmpty")
					alreadyUsed = true
				1:
					print("Something")
					$AnimationPlayer.play("HorizontalFull")
					player._changeCandies(10)
					alreadyUsed = true
					$AudioStreamPlayer.play()
				2:
					print("Boop Beep")
					$AnimationPlayer.play("HorizontalBoop")
					player._changeCandies(5)
					alreadyUsed = true
					$AudioStreamPlayer.play()
