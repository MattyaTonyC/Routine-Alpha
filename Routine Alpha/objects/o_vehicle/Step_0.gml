//
fuck_inputs_timer = max( fuck_inputs_timer-1, 0 )

if (is_on) && (keyboard_check_pressed(ord("E"))) && (fuck_inputs_timer == 0) {
	is_on = false
	sprite_index = sprite_off
	o_player.vehicle_mode = false
	fuck_inputs_timer = 3
}

if (is_on) {
	x += 1
	o_player.x = x
	o_player.y = y
}
