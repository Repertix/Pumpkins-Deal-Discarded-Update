extends CanvasLayer

func _ready():
	get_parent().get_node("LevelResources").connect("_callUI", self, "_callUI")

func _callUI(type):
	match type:
		"truck":
			$AnimationPlayer.play("incomingTruck"	)
