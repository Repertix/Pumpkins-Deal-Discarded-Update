extends Area2D

var time = 5

func _ready():
	$AnimationPlayer.play("idle")


func _statsUpdate(element, stat, value):
	if element == "Time":
		match stat:
			"timeGive":
				time += value
				print("[Time Clock] Giveable time increased/decreased to "+str(value))

func _bodyEntered(body):
	if body.name == "Player":
			if !$CollisionShape2D.disabled:
				get_parent().get_parent().get_parent().get_parent()._IorDTime(time)
				$Sprite.visible = false
				$AudioStreamPlayer.play()
				$CollisionShape2D.disabled = true
			
	pass # Replace with function body.


func _on_wow():
	queue_free()
	pass # Replace with function body.
