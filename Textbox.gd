extends Panel



var actuallyInteracting = false
var actualSelection = 0
var currentText = 0
var efaces = []
export var pausedTextbox = false#In case of cinematics
var entireText = ["Hello, Mr. Adam", "Thanks for testing!", "We still cleaning some things", "If you read this, don't resist to tell him about it."]

func _ready():
	$RichTextLabel.set_visible_characters(0)

func _startTextbox(text:Array, faces:Array):
	$RichTextLabel.set_visible_characters(0)
	entireText = text
	currentText = 0
	efaces = faces
	_checkForFaces()
	$RichTextLabel.set_bbcode(text[currentText])
	actuallyInteracting = true

func _checkForFaces():
	if efaces[currentText] == -1:
		$Sprite.visible = false
		$RichTextLabel.margin_left = 24
		$RichTextLabel.set_size(Vector2(525, 91))
	else:
		$Sprite.visible = true
		$Sprite.frame = efaces[currentText]
		$RichTextLabel.margin_left = 160
		$RichTextLabel.set_size(Vector2(610, 91))


func _endTextbox():
	entireText = []
	currentText = 0
	$RichTextLabel.set_visible_characters(0)
	visible = false
	actuallyInteracting = false
	_checkForFaces()
	efaces = []
	get_parent().get_parent().endInteraction()
	

func _input(event):
	if actuallyInteracting:
		if !pausedTextbox:
			if Input.is_action_just_pressed("interact"):
				if $RichTextLabel.get_visible_characters() > $RichTextLabel.get_total_character_count():
					if currentText < entireText.size()-1:
						currentText += 1
						$RichTextLabel.set_bbcode(entireText[currentText])
						$RichTextLabel.set_visible_characters(0)
						_checkForFaces()
					else:
						_endTextbox()


func _on_timer():
	$RichTextLabel.set_visible_characters($RichTextLabel.get_visible_characters()+1)
