extends CanvasLayer
onready var gman = get_node("/root/GameManager")
var charSpr = [0,0,0,0]
func _ready():
	$Control/Candy/RichTextLabel.set_bbcode("0")
	$Control/Time/RichTextLabel.set_bbcode("400")
	$Control/MaxCandies/RichTextLabel.set_bbcode("50")
	$Control/Health/Sprite.frame = charSpr[0]

func _damageHp():
	$Control/Health/HPHead.play("damaged")

func _checkHealthHud(health, maxHealth):
	if health <= (maxHealth - (maxHealth*.25)) && health > (maxHealth - maxHealth*.50):
		print("75% Life")
	elif health <= (maxHealth - (maxHealth*.50)) && health > (maxHealth - (maxHealth*.75)):
		$Control/Health/AnimationPlayer.stop()
		$Control/Health/ProgressBar.get("custom_styles/fg").bg_color = Color(255,255,255)
		$Control/Health/Sprite.frame = charSpr[1]
	elif health <= (maxHealth - (maxHealth*.75)) && health > 0:
		$Control/Health/AnimationPlayer.play("lowHP")
		$Control/Health/Sprite.frame = charSpr[2]
	elif health == 0:
		$Control/Health/Sprite.frame = charSpr[3]
	else:
		$Control/Health/Sprite.frame = charSpr[0]

func _changeHudInfo(type, content, secondContent):
	match type:
		"candyCount":
			if content > 999999:
				$Control/Candy/RichTextLabel.set_bbcode("999999")
			else:
				$Control/Candy/RichTextLabel.set_bbcode(str(content))
		"health":
			$Control/Health/ProgressBar.value = content
			_checkHealthHud(content, secondContent)
		"maxCandies":
			$Control/MaxCandies/RichTextLabel.set_bbcode(str(content))
		"time":
			$Control/Time/RichTextLabel.set_bbcode(content)

func _changeHealthBar(value, valueTwo):
	$Control/Health/ProgressBar.max_value = value
	_checkHealthHud(valueTwo, value)

func _updateTime():
	var time = get_parent().time
	$Control/Time/RichTextLabel.set_bbcode(str(time))
	pass # Replace with function body.
