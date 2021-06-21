extends StaticBody2D
var doorClosed = 0
var time = 0
var doorReady = false
var candyToGive = 20

func _ready():
	get_parent().get_parent().get_parent().get_parent().get_parent().connect("statsUpdate", self, "_stats")
	randomize()
	doorClosed = randi()%5
	time = randi()%30+1
	$Sprite.frame = doorClosed
	$Timer.wait_time = time
	$Timer.start()
	pass 


func _stats(element, stat, value):
	if element == "Doors":
		match stat:
			"candies":
				candyToGive = value


func _interact(player):
	if doorReady:
		$Aval.visible = false
		randomize()
		var cans = randi()%candyToGive+1
		print(cans)
		player._changeCandies(cans)
		$Sprite.frame = randi()%14+6
		$OpenTime.start()
		$AudioStreamPlayer.play()
		doorReady = false

func _on_opened():
	doorReady = true
	$Aval.visible = true
	$AnimationPlayer.play("Available")
	$Timer.stop()
	pass # Replace with function body.


func _closeDoor():
	$Sprite.frame = doorClosed
	randomize()
	time = randi()%30
	$Timer.start(time)
	$OpenTime.stop()
	pass # Replace with function body.
