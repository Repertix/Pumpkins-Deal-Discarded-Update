extends KinematicBody2D

enum {
	IDLE,#Nobody's there
	CHASE,#Swiggity Swaty I'm Coming for dat Candy
	WANDER,#I want chicken nuggies.
	RESTING,#Broooooo, that's good shit.
	ATTACK#Fuck It. *unzips pants*
}

onready var state = IDLE
onready var player = null
onready var velocity = Vector2.ZERO
onready var speed = 50
onready var toHit = false
onready var damage = 1
var item = "Bully"

func _ready():
	get_parent().get_parent().get_parent().get_parent().connect("statsUpdate", self, "_statsUpdated")

func _statsUpdated(element, stat, value):
	if element == "Bully":
		match stat:
			"damage":
				damage += value
func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, 80)
			$AnimationTree.get("parameters/playback").travel("Idle")
		CHASE:
			if player != null:
				var direction = (player.global_position - global_position).normalized()
				$AnimationTree.get("parameters/playback").travel("Walk")
				$AnimationTree.set("parameters/Idle/blend_position", direction)
				$AnimationTree.set("parameters/Walk/blend_position", direction)
				$AnimationTree.set("parameters/Punch/blend_position", direction)
				velocity = velocity.move_toward(direction * speed, speed)
			pass
		WANDER:
			pass
		RESTING:
			if $RestTimer.is_stopped():
				$RestTimer.start()
			velocity = velocity.move_toward(Vector2.ZERO, 80)
			$AnimationTree.get("parameters/playback").travel("Idle")
			pass
		ATTACK:
			if $HitConfirm.is_stopped():
				$HitConfirm.start()
			$AnimationTree.get("parameters/playback").travel("Punch")
			velocity = velocity.move_toward(Vector2.ZERO, 80)
	velocity = move_and_slide(velocity)





func _restEnd():
	if player != null:
		state = CHASE
	elif player == null:
		state = IDLE
	elif toHit:
		state = ATTACK
	$RestTimer.stop()
	pass # Replace with function body.


func _on_PlayerDetected(body):
	if body.name == "Player":
		player = body
		if state != RESTING:
			state = CHASE
	
	if body.name != "Player":
		if not body.get("item") == null:
			if body.item == "Candy":
				body.queue_free()


func _on_Player_Exited(body):
	if body.name == "Player":
		player = null
		if state != RESTING:
			state = IDLE
	pass # Replace with function body.


func _HitConfirm(body):
	if player != null:
		if body == player:
			if state != RESTING:
				state = ATTACK
				toHit = true
	pass # Replace with function body.


func _HitNoConfirmed(body):
	if player != null:
		if body == player:
			if state != RESTING:
				toHit = false
	pass # Replace with function body.


func _ConfirmHit():
	if player != null:
		if toHit:
			randomize()
			state = RESTING
			get_parent().get_parent().get_parent().get_parent()._IorDTime(-10)
			if player.candy > 30:
				player._changeCandies(-randi()%20)
			player._hit(damage)
			$HitConfirm.stop()
		elif !toHit:
			state = RESTING
			$HitConfirm.stop()
	pass # Replace with function body.
