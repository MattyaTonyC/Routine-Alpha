//
function ui_text_button( x0,y0, text, func ) {
	var mx = window_mouse_get_x() / window_get_width() * display_get_gui_width()
	var my = window_mouse_get_y() / window_get_height() * display_get_gui_height()
	
	var inside = point_in_rectangle( mx,my, x0,y0, x0+string_width(text),y0+string_height(text) )
	var click = mouse_check_button_pressed(mb_left)
	
	if (inside) draw_set_colour(c_yellow)
	draw_text( x0,y0, text )
	draw_set_colour(c_white)
	
	if (inside && click) func()
}
