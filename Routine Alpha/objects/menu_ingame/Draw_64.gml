//
var gui_w = display_get_gui_width()
var gui_h = display_get_gui_height()
var mx = window_mouse_get_x() / window_get_width() * gui_w
var my = window_mouse_get_y() / window_get_height() * gui_h

//
if (keyboard_check_pressed(vk_escape)) pause_menu = !pause_menu

if (pause_menu) {
	//
	if (!pause_menu_prev) {
		inv_opened = false
		view_set_visible( 0, false )
		instance_deactivate_layer("Instances")
		instance_deactivate_layer("Player")
	}
	pause_menu_prev = true
	
	//
	draw_set_colour(c_black); draw_set_alpha(0.5)
	draw_rectangle( 0,0, gui_w,gui_h, false )
	draw_set_colour(c_white); draw_set_alpha(1)
	
	//
	var str = "Вы "
	switch (room) {
		case (r_house): str += "дома"; break
		case (r_city): str += "в городе"; break
	}
	draw_text( 100,100, str )
	draw_set_halign(fa_center)
	draw_text( gui_w/2,100, $"День 0" )
	draw_set_halign(fa_right)
	draw_text_transformed( gui_w-100,75, $"real time", 0.5,0.5,0 )
	str = string(current_minute)
	if (string_length(str) < 2) str = "0" + str
	draw_text( gui_w-100,100, $"{current_hour}:{str}" )
	draw_text_transformed( gui_w-100,175, $"fake time", 0.5,0.5,0 )
	draw_text( gui_w-100,200, $"{int64(24*(current_day-1)/31)}:{int64(5*current_month)}" )
	draw_set_halign(fa_left)
	//
	ui_text_button( 100,gui_h/2-100, "Продолжить", function(){pause_menu = false} )
	ui_text_button( 100,gui_h/2, "Настройки", function(){settings_opened = !settings_opened} )
	ui_text_button( 100,gui_h/2+100, "Вернуться в меню", function(){transition.target = r_menu_main} )
	
	if (settings_opened) {
		draw_settings( 640, 300, 0 )
		draw_settings( 900, 300, 1 )
		draw_settings( 640, 555, 2 )
	}
}
if (!pause_menu) {
	//
	if (pause_menu_prev) {
		settings_opened = false
		view_set_visible( 0, true )
		instance_activate_layer("Instances")
		instance_activate_layer("Player")
	}
	pause_menu_prev = false
	
	//
	draw_set_colour(c_maroon)
	draw_rectangle( gui_w/2-200,25, gui_w/2+200,50, false )
	draw_rectangle( gui_w/2-200-2,25-2, gui_w/2+200+3,50+3, true )
	draw_set_colour(c_red)
	draw_rectangle( gui_w/2-200,25, gui_w/2-200+4*o_player.hp,50, false )
	draw_set_colour(c_white)
	
	//
	hover.inv = noone
	hover.slot = noone
	if (keyboard_check_pressed(vk_tab)) inv_opened = !inv_opened
	if (!inv_opened) {
		if (drag.inv != noone) {
			drag.inv[drag.slot].id = drag_hold.id
			drag.inv[drag.slot].count += drag_hold.count
		}
		drag.inv = noone
		drag.slot = noone
		drag_hold.id = noone
		drag_hold.count = 0
	}
	
	inventory_draw( gui_w/2, gui_h-75, o_player.inventory.active )
	
	if (inv_opened) {
		var inst = noone
		var interactive = noone
		if (instance_exists(o_storage)) {
			inst = instance_nearest( o_player.x,o_player.y, o_storage )
			var dis = point_distance( o_player.x,o_player.y, inst.x,inst.y )
			
			if (dis <= 15) {
				interactive = inst.inventory.passive
				inst.is_open = true
			}
		}
		
		if (interactive != noone) inventory_draw( gui_w/2, gui_h-225, interactive )
		inventory_draw( gui_w/2+475, gui_h-212.5, o_player.inventory.passive, array_length(o_player.inventory.passive)/2 )
		
		//
		if (hover.inv != noone) if (hover.inv[hover.slot].id != noone) {
			var info = struct_get( global.item_list, hover.inv[hover.slot].id )
			
			if (drag.inv == noone) {
				draw_set_colour(c_black); draw_set_alpha(0.5)
				draw_rectangle( mx+10-2,my-5, mx+10+2+string_width(info.name)/2,my-5+2+string_height(info.name)/2, false )
				draw_set_colour(c_white); draw_set_alpha(1)
				draw_text_transformed( mx+10,my-5, info.name, 0.5,0.5,0 )
			}
		}
		
		//
		if (mouse_check_button_pressed(mb_left)) && (hover.inv != noone) if (hover.inv[hover.slot].id != noone) {
			drag.inv = hover.inv
			drag.slot = hover.slot
			drag_hold.id = hover.inv[hover.slot].id
			drag_hold.count = hover.inv[hover.slot].count
			hover.inv[hover.slot].id = noone
			hover.inv[hover.slot].count = 0
		}
		
		if (drag.inv != noone) {
			var info = struct_get( global.item_list, drag_hold.id )
			
			draw_sprite_ext( info.icon,0, mx,my, 10,10,0, c_white,1)
			
			draw_set_colour(c_black); draw_set_alpha(0.5)
			draw_rectangle( mx+50-string_width(drag_hold.count)/2-2,my+50-string_height(drag_hold.count)/2+1, mx+50,my+50, false )
			draw_set_colour(c_white); draw_set_alpha(1)
			
			draw_set_halign(fa_right); draw_set_valign(fa_bottom)
			draw_text_transformed( mx+50,my+50, drag_hold.count, 0.5,0.5,0 )
			draw_set_halign(fa_left); draw_set_valign(fa_top)
		}
		
		if (mouse_check_button_released(mb_left)) && (drag.inv != noone) {
			if (hover.inv != noone) {
				if (hover.inv[hover.slot].id == drag_hold.id) hover.inv[hover.slot].count += drag_hold.count
				else {
					if (hover.inv[hover.slot].id != noone) {
						drag.inv[drag.slot].id = hover.inv[hover.slot].id
						drag.inv[drag.slot].count = hover.inv[hover.slot].count
					}
					hover.inv[hover.slot].id = drag_hold.id
					hover.inv[hover.slot].count = drag_hold.count
				}
			}
			else {
				drag.inv[drag.slot].id = drag_hold.id
				drag.inv[drag.slot].count += drag_hold.count
			}
			drag.inv = noone
			drag.slot = noone
			drag_hold.id = noone
			drag_hold.count = noone
		}
		
		if (mouse_check_button_pressed(mb_right)) && (drag.inv != noone) {
			if (hover.inv != noone) if (hover.inv[hover.slot].id == noone) || (hover.inv[hover.slot].id == drag_hold.id) {
				drag_hold.count -= 1
				hover.inv[hover.slot].id = drag_hold.id
				hover.inv[hover.slot].count += 1
				if (drag_hold.count == 0) {
					drag.inv = noone
					drag.slot = noone
					drag_hold.id = noone
					drag_hold.count = 0
				}
			}
		}
	}
}
