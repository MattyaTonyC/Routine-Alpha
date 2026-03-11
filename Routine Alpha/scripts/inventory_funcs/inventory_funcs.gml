//
function empty_slot() constructor {
	id = noone
	count = 0
}

//
function inventory_create( active_len, passive_len ) constructor {
	active = []
	repeat (active_len) array_push( active, new empty_slot() )
	
	passive = []
	repeat (passive_len) array_push( passive, new empty_slot() )
}

//
function inventory_draw( x0,y0, inv, row_len=array_length(inv) ) {
	var mx = window_mouse_get_x() / window_get_width() * display_get_gui_width()
	var my = window_mouse_get_y() / window_get_height() * display_get_gui_height()
	
	draw_set_colour(c_black); draw_set_alpha(0.5)
	draw_rectangle( x0-125*(row_len-1)/2-61, y0-60, x0+125*(row_len-1)/2+60, y0+125*((array_length(inv)-1)div row_len)+61, false )
	draw_set_colour(c_white); draw_set_alpha(1)
	draw_rectangle( x0-125*(row_len-1)/2-61, y0-60, x0+125*(row_len-1)/2+60, y0+125*((array_length(inv)-1)div row_len)+61, true )
	
	for (var i=0; i<array_length(inv); i++) {
		var sx = x0 + 125*((i mod row_len) - (row_len-1)/2)
		var sy = y0 + 125*(i div row_len)
		
		draw_set_colour(c_dkgray)
		draw_rectangle( sx-10,sy-10, sx+10,sy+10, true )
		draw_set_colour(c_white)
		
		var show = true
		if (menu_ingame.drag.inv != noone) if (inv[i] == menu_ingame.drag.inv[menu_ingame.drag.slot]) show = false
		
		if (inv[i].id != noone) && (show) {
			var info = struct_get( global.item_list, inv[i].id )
			
			draw_sprite_ext( info.icon,0, sx,sy, 10,10,0, c_white,1 )
			
			draw_set_colour(c_black); draw_set_alpha(0.5)
			draw_rectangle( sx+50-string_width(inv[i].count)/2-2,sy+50-string_height(inv[i].count)/2+1, sx+50,sy+50, false )
			draw_set_colour(c_white); draw_set_alpha(1)
			
			draw_set_halign(fa_right); draw_set_valign(fa_bottom)
			draw_text_transformed( sx+50,sy+50, inv[i].count, 0.5,0.5,0 )
			draw_set_halign(fa_left); draw_set_valign(fa_top)
		}
		
		var inside = point_in_rectangle( mx,my, sx-50,sy-50, sx+50,sy+50 )
		if (inside) {
			menu_ingame.hover.inv = inv
			menu_ingame.hover.slot = i
		}
	}
}