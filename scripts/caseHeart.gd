extends Area2D
var healthGive = 1

func _ready():
	$AnimationPlayer.play("idle")
	self.connect("body_entered", self, "_giveHealth")

func _stats(element, stat, value):
	if element == "hearth":
		match stat:
			"cure":
				healthGive += value

func _giveHealth(body):
	if body.name == "Player":
		if !$CollisionShape2D.disabled:
			body.health += healthGive
			body._checkHealth()
			$Sprite.visible = false
			$CollisionShape2D.disabled = true
			$AudioStreamPlayer.play()


func _on_ddd():
	queue_free()
	pass # Replace with function body.
