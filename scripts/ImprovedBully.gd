extends KinematicBody2D

onready var nv : = $Navigation2D
var path : = PoolVector2Array() setget set_path
func _input(event):
	var new_path = $Navigation2D.get_simple_path(self.get_global_position(), event.global_position)
	$Line2D.points = new_path

func _process(delta):
	var move_distance = 50 * delta
	move_along_path(move_distance)

func move_along_path(distance : float)-> void:
	var start_point : = position
	for i in range(path.size()):
		var distance_to_next : = start_point.distance_to(path[0])
		if distance <= distance_to_next and distance >= 0.0:
			position = start_point.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0.0:
			position = path[0]
			set_process(false)
			break
		
		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)

func set_path(value : PoolVector2Array) -> void:
	path = value
	if value.size() == 0:
		return
	set_process(true)
	
