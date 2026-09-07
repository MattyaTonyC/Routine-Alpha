//
sprite_index = sprite_off

is_on = false
fuck_inputs_timer = 3

func = function() {
	if (fuck_inputs_timer == 0) {
		is_on = true
		sprite_index = sprite_on
		o_player.vehicle_mode = true
		fuck_inputs_timer = 3
	}
}
