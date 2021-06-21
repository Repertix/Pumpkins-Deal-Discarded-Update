extends CanvasLayer
onready var scene = get_parent()
var sceneCase = null
onready var selectedScene = null
var alreadyUsing = false

func _ready():
	$Transinator.connect("timeout", self, "afterAction")
	_startScene()

func _startScene():
	$AnimationPlayer.play("fadeOut")
	$Transinator.start()
	sceneCase = "sceneStart"

func afterAction():
	if sceneCase == "sceneEnd":
		if typeof(selectedScene) != 5:
			if selectedScene != null:
				get_tree().change_scene(selectedScene)
				get_tree().paused = false
				selectedScene = null
				alreadyUsing = false
		else:
			get_parent().get_node("Level/EntireLevel/AliveThings/Player").set_position(selectedScene)
			get_tree().paused = false
			selectedScene = null
			alreadyUsing = false
			$AnimationPlayer.play("fadeOut")
			$Transinator.start()
	
	if sceneCase == "sceneStart":
		if scene.has_method("_start"):
			scene._start()
	$Transinator.stop()

func _goTo(sccene):
	if alreadyUsing: return
	$AnimationPlayer.play("fadeIn")
	$Transinator.start()
	selectedScene = sccene
	sceneCase = "sceneEnd"
	alreadyUsing = true

