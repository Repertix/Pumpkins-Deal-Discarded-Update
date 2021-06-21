extends KinematicBody2D

#Movement and Interaction
export var speed = 80
export var disOffset = [Vector2(0,32), Vector2(0,0), Vector2(-16, 16), Vector2(16, 16)]
var velocity = Vector2()



#Interaction and Candies
var object = null
var candy = 0
var hitCnf = false
export (int, 0,4) var health = 4
var maxHealth = 4
var maxCandies = 50 #Fuck it. Deal with it.
signal candyMetaReached


func _ready():
	self.connect("candyMetaReached", get_parent().get_parent().get_parent().get_parent(), "_nextRound")
	get_parent().get_parent().get_parent().get_parent().connect("statsUpdate", self, "_statsUpdate")
	$HitTimer.connect("timeout", self, "_hitEnd")
	$InteractMachine.connect("body_entered", self, "_on_body")
	$InteractMachine.connect("body_exited", self, "_on_unbody")
	_checkHealth()

func _statsUpdate(element, stat, value):
	if element == "Player":
		match stat:
			"health":#Now Useless! 25% OFF!!!
				if maxHealth < 20:
					maxHealth += value
				elif maxHealth > 20:
					maxHealth == 20
				get_parent().get_parent().get_parent().get_parent().get_node("HUD")._changeHealthBar(maxHealth, health)
			"candieMax":
				maxCandies += value


func _changeCandies(amount):
	candy += amount
	if candy >= maxCandies:
		emit_signal("candyMetaReached")
	get_parent().get_parent().get_parent().get_parent().get_node("HUD")._changeHudInfo("candyCount", candy, "Candy Sent!")


func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	if !hitCnf:
		if input_vector != Vector2.ZERO:
			$AnimationTree.get("parameters/playback").travel("Walk")
			$AnimationTree.set("parameters/Idle/blend_position", input_vector)
			$AnimationTree.set("parameters/Walk/blend_position", input_vector)
			$InteractMachine.position = Vector2(input_vector.x*20, input_vector.y*20)
			velocity = velocity.move_toward(input_vector*speed, speed)
		else:
			$AnimationTree.get("parameters/playback").travel("Idle")
			velocity = velocity.move_toward(Vector2.ZERO, speed)
		
		
		
		if Input.is_action_just_pressed("interact"):
			if object != null:
				object._interact(self)
	else:
		$AnimationTree.get("parameters/playback").travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, speed)
	velocity = move_and_slide(velocity)
	

func _hit(damage):
	#WHY THIS MF DOES WORK ONCE AND NOT WITH TRUCKSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
	get_parent().get_parent().get_parent().get_parent().get_node("HUD")._damageHp()
	$HitTimer.start()
	$Hit.play()
	health -= damage
	hitCnf = true
	_checkHealth()

func _die():
	hitCnf = true
	get_parent().get_parent().get_parent().get_parent()._finishGame()

func _on_body(body):
	if body.has_method("_interact"):
		if object == null:
			object = body
	pass # Replace with function body.


func _checkHealth():
	
	if health < (maxHealth - (maxHealth*.25)):
		get_parent().get_parent().get_parent().get_parent()._callForHelp(true)
	else:
		get_parent().get_parent().get_parent().get_parent()._callForHelp(false)
	
	if health > maxHealth:
		health = maxHealth
		_checkHealth()
	
	if health < 0:
		health = 0
	get_parent().get_parent().get_parent().get_parent().get_node("HUD")._changeHudInfo("health", health, maxHealth)
	if health == 0:
		_die()

func _hitEnd():
	hitCnf = false
	$HitTimer.stop()


#Gonna shoot the mf over this.
func _on_unbody(body):
	if body.has_method("_interact"):
		if body == object:
			object = null
	pass # Replace with function body.
