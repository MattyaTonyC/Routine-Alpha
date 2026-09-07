//
if (spd.x != 0) || (spd.y != 0) {
	if (keyboard_check(vk_shift)) sprite_index = s_player_run
	else sprite_index = s_player_walk
}
else sprite_index = s_player_idle

if (spd.x != 0) image_xscale = sign(spd.x)

if (!vehicle_mode) draw_self()
