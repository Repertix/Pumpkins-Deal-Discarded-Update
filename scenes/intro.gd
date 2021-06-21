extends CanvasLayer

var phrase_data


func _ready():
	$Phrase.self_modulate.a = 0
	$Phrase.self_modulate.a = 0
	randomize()
	
	var phrasedata_file = File.new()
	phrasedata_file.open("res://misc/intro-texts.json", File.READ)
	var phrase_json = JSON.parse(phrasedata_file.get_as_text())
	phrase_data = phrase_json.result
	var phraseSelect = randi()%(phrase_data.size()-1)
	$Phrase.set_bbcode('"'+phrase_data[str(phraseSelect)].message+'"')
	$Author.set_bbcode("-"+phrase_data[str(phraseSelect)].author)
	$AnimationPlayer.play("phrase")
	$Timer.start()




func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/title.tscn")
	pass # Replace with function body.
