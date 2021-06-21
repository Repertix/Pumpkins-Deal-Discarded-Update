extends Area2D
var cnd = load("res://objects/candy.tscn")
var clocks = false
var hearts = false
var ambulance = false
var bullies = false
var candysPerTimeout = 5
var clocksPerTimeout = 3
var heartsPerTimeout = randi()%4+1

func _ready():
	get_parent().get_parent().get_parent().get_parent().connect("statsUpdate", self, "_stats")
	$Timer.connect("timeout", self, "_checkGenerate")

func _stats(element, type, value):
	if element == "Generator":
		match type:
			"generateHearts":
				hearts = value
			"generateClocks":
				clocks = value

func _checkGenerate():
	_generateCandy(candysPerTimeout)
	if hearts:
		_generateHearts(heartsPerTimeout)
	if clocks:
		_generateClock(clocksPerTimeout)



func _generateHearts(amount):
	for i in amount:
		var heart = load("res://objects/Heart.tscn")
		var hp = heart.instance()
		var dk = $CollisionShape2D.shape.extents
		hp.position = Vector2(randi()%(int(dk.x)*2)-int(dk.x), randi()%(int(dk.y)*2)-int(dk.y))
		call_deferred("add_child", hp)#*HP Laptop starts booting up*




#YandereDev no se preocuparía por esto. Pero joder, el nunca ha tenido una tostadora o que pedo? xDDDDDDDD
func _generateCandy(amount):
	for i in amount:
		var candy = load("res://objects/candy.tscn")
		var cp = candy.instance()
		var dk = $CollisionShape2D.shape.extents
		cp.position = Vector2(randi()%(int(dk.x)*2)-int(dk.x), randi()%(int(dk.y)*2)-int(dk.y))
		call_deferred("add_child", cp)

func _generateClock(amount):
	for i in amount:
		var clock = load("res://objects/clock.tscn")
		var cl = clock.instance()
		var dk = $CollisionShape2D.shape.extents
		cl.position = Vector2(randi()%(int(dk.x)*2)-int(dk.x), randi()%(int(dk.y)*2)-int(dk.y))
		call_deferred("add_child", cl)

#func _generate_candie():
	#var candy = get_parent().get_node("Coin/Coin")
	#var dCandy = candy.duplicate()
	#dCandy.position.x = rand_range(72.1, 1161.1)
	#dCandy.position.y = rand_range(-120.1, -67.1)
	#get_parent().get_node("Coin").add_child(dCandy)
