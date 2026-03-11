//
var gui_w = display_get_gui_width()
var gui_h = display_get_gui_height()
var mx = window_mouse_get_x() / window_get_width() * gui_w
var my = window_mouse_get_y() / window_get_height() * gui_h

/// ОТРИСОВКА ПОВЕРХНОСТИ ДВЕРИ
if (!surface_exists(door_surface)) {
	door_surface = surface_create( gui_w, gui_h )
	surface_set_target(door_surface)
	
	// дверь
	draw_set_colour(make_colour_rgb(96,96,96))
	draw_rectangle( 0,0, gui_w,gui_h, false )
	draw_set_colour(c_black); draw_set_alpha(0.2)
	draw_rectangle( 150,150, 316,gui_h, false )
	draw_set_colour(c_gray); draw_set_alpha(1)
	draw_rectangle( 150,150, 300,gui_h, false )
	// стикер
	draw_set_colour(c_black); draw_set_alpha(0.2)
	draw_rectangle( gui_w/2-200+16,gui_h/2-125, gui_w/2+216,gui_h/2+216, false )
	draw_set_colour(make_colour_rgb(250,250,153)); draw_set_alpha(1)
	draw_rectangle( gui_w/2-200,gui_h/2-200, gui_w/2+200,gui_h/2+200, false )
	draw_set_colour(make_colour_rgb(250,250,178))
	draw_rectangle( gui_w/2-200,gui_h/2-200, gui_w/2+200,gui_h/2-125, false )
	// текст
	draw_set_colour(c_navy)
	for (var i=0; i<array_length(buttons); i++) {
		var ui_x = gui_w/2 - 125
		var ui_y = gui_h/2 - 100 + 75*i
		draw_rectangle( ui_x-30-7,ui_y+27-7, ui_x-30+7,ui_y+27+7, false )
		draw_text( ui_x, ui_y, buttons[i].text )
	}
	draw_set_colour(c_white)
	// магнитики
	draw_sprite_ext(s_magnets,0, 1700,200, 16,16,-10, c_white,1 )
	draw_sprite_ext(s_magnets,1, 1500,500, 16,16,15, c_white,1 )
	
	surface_reset_target()
}
//
if (door_timer <= 90) {
	door_timer += 1
	door_value = sin(degtorad(door_timer))
}
else door_value = 1

draw_set_colour(c_dkgray)
draw_rectangle( (1-door_value)*1.5*(gui_w-200),0, gui_w,gui_h, false )
draw_set_colour(c_white)
draw_surface_ext( door_surface, (1-door_value)*1.5*gui_w,(1-door_value)*-gui_h/2, door_value,2-door_value,0, c_white,1 )

/// ФУНКЦИОНАЛ КНОПОК
var no_hover = true
for (var i=0; i<array_length(buttons); i++) {
	var ui_x = gui_w/2 - 125
	var ui_y = gui_h/2 - 100 + 75*i
	
	var inside = point_in_rectangle( mx,my, ui_x,ui_y, ui_x+string_width(buttons[i].text),ui_y+string_height(buttons[i].text) )
	if (door_value == 1) && (inside || buttons[i].pressed) {
		if (inside) {
			draw_set_colour(c_navy)
			draw_line_width( ui_x,ui_y+50, ui_x+string_width(buttons[i].text)+5,ui_y+50, 5 )
			draw_set_colour(c_white)
		}
		if (buttons[i].pressed) {
			draw_set_colour(c_navy)
			draw_line_width( ui_x-5,ui_y+27, ui_x+string_width(buttons[i].text)+15,ui_y+27, 5 )
			draw_line_width( ui_x-10,ui_y+37, ui_x+string_width(buttons[i].text)+10,ui_y+37, 5 )
			draw_set_colour(c_white)
		}
		
		if (inside && mouse_check_button_pressed(mb_left) && (transition.target == noone)) {
			buttons[i].func()
			buttons[i].pressed = !buttons[i].pressed
		}
		
		if (inside) && (transition.target == noone) {
			no_hover = false
			if (hover_prev != i) audio_play_sound( snd_pen_1, 0,false, 1,0, random_range(1,1.5) )
			hover_prev = i
		}
		if (inside) && (mouse_check_button_pressed(mb_left)) audio_play_sound( snd_pen_2, 0,false, 1,0, random_range(0.8,1.2) )
	}
}
if (no_hover) hover_prev = noone

/// НАСТРОЙКИ
if (settings_opened) {
	draw_settings( 400, 800, 0 )
	draw_settings( 660, 800, 1 )
	draw_settings( 970, 800, 2 )
}
