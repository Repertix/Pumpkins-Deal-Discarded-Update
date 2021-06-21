extends CanvasLayer

func _ready():
	$Sprite.visible = false
	get_tree().paused = false
	$Timer.connect("timeout", self, "startGame")

func _callText():
	$Timer.start()
	$AnimationPlayer.play("rsg")
	$Sprite.visible = true
	get_tree().paused = true

func startGame():
	get_tree().paused = false
	if get_parent().get_node("pauseMenu") != null:
		get_parent().get_node("pauseMenu").pausable = true
	$Timer.stop()
	queue_free()
