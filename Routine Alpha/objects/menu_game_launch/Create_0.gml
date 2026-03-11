//
draw_set_font(font_Monocraft)
cursor_sprite = s_cursor_game_launch

//
global.entrance = 0
global.inventory = noone

//
audio_group_load(sounds)
audio_group_load(music)

audio_master_gain(global.settings.master_volume)
audio_group_set_gain(sounds, global.settings.sound_volume)
audio_group_set_gain(music, global.settings.music_volume)

window_enable_borderless_fullscreen(global.settings.borderless_screen)
window_set_showborder(!global.settings.borderless_screen)
window_set_fullscreen(global.settings.fullscreen_screen)
if (!global.settings.fullscreen_screen) {
	window_set_size( 0.75*display_get_width(), 0.75*display_get_height() )
	window_set_position( 100, 100 )
}

//
timer = 0