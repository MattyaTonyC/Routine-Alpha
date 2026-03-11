
/// ЗАТЕМНЕНИЕ
function ta_fade(t) {
	var gui_w = display_get_gui_width()
	var gui_h = display_get_gui_height()
	
	draw_set_colour(c_black); draw_set_alpha(t)
	draw_rectangle( 0,0, gui_w,gui_h, false )
	draw_set_colour(c_white); draw_set_alpha(1)
	
	return 1/60
}

/// РАЗДВИГАНИЕ
function ta_curtains(t) {
	var gui_w = display_get_gui_width()
	var gui_h = display_get_gui_height()
	
	draw_set_colour(c_black)
	draw_rectangle( 0,0, t*gui_w/2,gui_h, false )
	draw_rectangle( gui_w/2*(2-t),0, gui_w,gui_h, false )
	draw_set_colour(c_white)
	
	return 1/30
}
