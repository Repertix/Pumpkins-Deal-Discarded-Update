extends Navigation2D

export(float) var char_speed = 400.0
var path = []

func _input(event):
	if not event.is_action_pressed("click"):
		return
	_update_path($BullTheY.position, get_local_mouse_position())

func _update_path(charPos, mousePos):
	get_simple_path(charPos, mousePos, true)
	path.remove(0)
	set_process(true)

func _process(delta):
	var wlk_dis = char_speed * delta
	move_along_path(wlk_dis)

func move_along_path(distance):
	print($BullTheY.position)
	var last_point = $BullTheY.position
	for index in range(path.size()):
		var distance_bt_pnts = last_point.distance_to(path[0])
		if distance <= distance_bt_pnts:
			$BullTheY.position = last_point.linear_interpolate(path[0], distance / distance_bt_pnts)
			break
		elif distance < 0.0:
			$BullTheY.position = path[0]
			set_process(false)
			break
		distance -= distance_bt_pnts
		last_point = path[0]
		path.remove(0)

