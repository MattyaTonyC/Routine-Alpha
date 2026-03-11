//
if (room_theme != noone) {
	if (!audio_is_playing(room_theme)) audio_play_sound( room_theme, 0,false )
	audio_sound_gain( room_theme, 1-transition.timer/2 )
}
