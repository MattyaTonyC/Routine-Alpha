//
switch (target) {
	case (room):
		timer -= animation(timer)
		if (timer <= 0) target = noone
		break
	
	case (noone):
		break
	
	default:
		timer += animation(timer)
		if (timer >= 1) room_goto(target)
}
