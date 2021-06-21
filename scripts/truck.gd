extends Node2D
signal finished
var hit = false
var removeCandies = 34
var state
var item = "Truck"
enum {
	idle,
	trip
}

func _ready():
	state = idle
	$Truck/AnimationPlayer.play("goingFuck")
	$Truck.set_position($Entrance.position)
	$Truck/Area2D.connect("body_entered", self, "_newBody")
	get_tree().get_root().get_node("EntireGame").connect("statsUpdate", self, "_stats")
	self.connect("finished",get_parent().get_parent().get_parent().get_parent().get_node("LevelResources"), "_restartContainers")

func _physics_process(delta):
	var motion = Vector2()
	match state:
		trip:
			if $Truck.position.x >= $Exit.position.x:
				state = idle
			motion.x += 250
		idle:
			if hit: hit = false;
			if $Truck.position.x >= $Exit.position.x:
				emit_signal("finished")
				$Truck.set_position($Entrance.position)
			motion.x = 0
	
	motion = $Truck.move_and_slide(motion)

func _newBody(body):
	if body.name == "Player":
		if !hit:
			body._hit(2)
			hit = true
			if body.candy > 100:
				body._changeCandies(-removeCandies)
			

func _stats(element, stat, value):
	if element == "truck":
		match stat:
			"damage":
				removeCandies = value
			"going":
				print("Goin'")
				state = trip
