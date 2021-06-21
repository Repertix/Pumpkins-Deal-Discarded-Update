extends Area2D
signal increaseCandies(amount) #Do not use this shit
var alG = false
func _ready():
	randomize()
	$Sprite.frame = randi()%5
	$AnimationPlayer.play("candy")


func _stats(element, stat, value):
	if element == "candy":
		match stat:
			"free":
				queue_free()

func _on_body(body):
	if body.name == "Player":
		if !$CollisionShape2D.disabled:
			body._changeCandies(1)
			$Sprite.visible = false
			$CollisionShape2D.set_deferred("disabled", true)
			$gottem.play()
	
	if body.name != "Player":
		if not body.get("item") == null:
			if body.item == "Truck" or body.item == "Bully":
				queue_free()
		
		match body.name:
			"Truck":
				queue_free()
	pass # Replace with function body.


func _on_audio():
	queue_free()
	pass # Replace with function body.
