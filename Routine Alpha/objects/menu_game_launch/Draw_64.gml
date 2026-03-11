//
var gui_w = display_get_gui_width()
var gui_h = display_get_gui_height()


/// ЛОГО
var arg = current_time/180

// фон
draw_circle_colour( gui_w/2,gui_h/2, gui_w/2, make_colour_rgb(40,0,20),c_black, false )
// заглушка между зубами
draw_set_colour(c_black)
draw_circle( gui_w/2, gui_h/2, 75, false )
draw_set_colour(c_white)

// левый текст
draw_sprite_ext( s_botv_text,0, gui_w/2 - 130, gui_h/2 - 40, 10,10, -5+sin(arg), c_white,1 )
draw_sprite_ext( s_botv_text,2, gui_w/2 - 130, gui_h/2 + 40, 10,10, 5-sin(arg), c_white,1 )
// череп
draw_sprite_ext( s_botv_logo,0, gui_w/2+10+cos(-arg),gui_h/2-100+sin(-arg), 15,15,10+sin(-arg), c_white,1 )
draw_sprite_ext( s_botv_logo,1, gui_w/2+15+cos(arg),gui_h/2+40+sin(arg), 15,15,-10+sin(arg), c_white,1 )
// правый текст
draw_sprite_ext( s_botv_text,1, gui_w/2 + 110, gui_h/2 - 40, 10,10, 5-sin(arg), c_white,1 )
draw_sprite_ext( s_botv_text,3, gui_w/2 + 110, gui_h/2 + 40, 10,10, -5+sin(arg), c_white,1 )

//
if (transition.target == noone) timer += 1
if (timer >= 60) transition.target = r_menu_main
