//
ini_open("settings")
settings = {
	master_volume: ini_read_real( "audio", "master_volume", 0.5 ),
	sound_volume: ini_read_real( "audio", "sound_volume", 0.5 ),
	music_volume: ini_read_real( "audio", "music_volume", 0.5 ),
	silent_without_focus: ini_read_real( "audio", "silent_without_focus", 0 ),
	
	fullscreen_screen: ini_read_real( "video", "fullscreen_screen", 1 ),
	borderless_screen: ini_read_real( "video", "borderless_screen", 1 ),
	vsync: ini_read_real( "video", "vsync", 1 ),
	postprocessing: ini_read_real( "video", "postprocessing", 0 ),
	
	camera_smoothness: ini_read_real( "camera", "camera_smoothness", 0.5 ),
	camera_mouse_influence: ini_read_real( "camera", "camera_mouse_influence", 0.5 ),
	camera_shaking: ini_read_real( "camera", "camera_shaking", 0 ),
	camera_zoom_speed: ini_read_real( "camera", "camera_zoom_speed", 0 ),
}
ini_close()

//
function draw_settings( x0,y0, type ) {
	var mx = window_mouse_get_x() / window_get_width() * display_get_gui_width()
	var my = window_mouse_get_y() / window_get_height() * display_get_gui_height()
	
	//
	var info = []
	var w = 240
	var h = 235
	switch (type) {
		case (0):
			info = [
				{ text: "Общая", setting: "master_volume", type: "slider" },
				{ text: "Звуки", setting: "sound_volume", type: "slider" },
				{ text: "Музыка", setting: "music_volume", type: "slider" },
				{ text: "Вне фокуса", setting: "silent_without_focus", type: "checkbox" }
			]
			break
		case (1):
			w = 290
			info = [
				{ text: "Полный экран", setting: "fullscreen_screen", type: "checkbox" },
				{ text: "Безрамочный", setting: "borderless_screen", type: "checkbox" },
				{ text: "Верт.синхр.", setting: "vsync", type: "checkbox" },
				{ text: "Постпроц.", setting: "postprocessing", type: "checkbox" }
			]
			break
		case (2):
			w = 340
			info = [
				{ text: "Плавность", setting: "camera_smoothness", type: "slider" },
				{ text: "Влияние мыши", setting: "camera_mouse_influence", type: "slider" },
				{ text: "Тряска", setting: "camera_shaking", type: "slider" },
				{ text: "Скорость зума", setting: "camera_zoom_speed", type: "slider" }
			]
			break
	}
	
	//
	draw_set_colour(c_black); draw_set_alpha(0.5)
	draw_rectangle( x0-3,y0-3, x0+w+2,y0+h+2, false)
	draw_set_colour(c_white); draw_set_alpha(1)
	draw_rectangle( x0,y0, x0+w,y0+h, true)
	draw_sprite( s_settings_icons,type, x0+20,y0+20 )
	
	//
	var changed = false
	for (var i=0; i<array_length(info); i++) {
		var ui_y = y0+45*(i+1)
		
		draw_text_transformed( x0+20,ui_y, info[i].text, 0.5,0.5,0 )
		
		var setting = struct_get( global.settings, info[i].setting )
		switch (info[i].type) {
			case ("slider"):
				draw_line_width( x0+w-120,ui_y+15, x0+w-20,ui_y+15, 2 )
				draw_rectangle( x0+w-120-5+setting*100,ui_y+5, x0+w-120+5+setting*100,ui_y+25, true )
				draw_rectangle( x0+w-120-3+setting*100,ui_y+7, x0+w-120+2+setting*100,ui_y+22, false )
				
				var inside = point_in_rectangle( mx,my, x0+w-120-5,ui_y+5, x0+w-20+5,ui_y+25 )
				var click = mouse_check_button(mb_left)
				if (inside && click) {
					struct_set( global.settings, info[i].setting, round((mx-x0-w+120)/10)/10 )
					changed = true
				}
				break
			
			case ("checkbox"):
				draw_rectangle( x0+w-40,ui_y+5, x0+w-20,ui_y+25, true )
				if (setting) draw_rectangle( x0+w-40+2,ui_y+7, x0+w-20-3,ui_y+22, false )
				
				var inside = point_in_rectangle( mx,my, x0+w-40,ui_y+5, x0+w-20,ui_y+25 )
				var click = mouse_check_button_pressed(mb_left)
				if (inside && click) {
					struct_set( global.settings, info[i].setting, !setting )
					changed = true
				}
				break
		}
	}
	
	//
	if (!changed) return
	switch (type) {
		case (0):
			audio_master_gain(global.settings.master_volume)
			audio_group_set_gain(sounds, global.settings.sound_volume)
			audio_group_set_gain(music, global.settings.music_volume)
			
			ini_open("settings")
			ini_write_real( "audio", "master_volume", global.settings.master_volume )
			ini_write_real( "audio", "sound_volume", global.settings.sound_volume )
			ini_write_real( "audio", "music_volume", global.settings.music_volume )
			ini_write_real( "audio", "silent_without_focus", global.settings.silent_without_focus )
			ini_close()
			break
		
		case (1):
			window_enable_borderless_fullscreen(global.settings.borderless_screen)
			window_set_showborder(!global.settings.borderless_screen)
			
			window_set_fullscreen(global.settings.fullscreen_screen)
			if (!global.settings.fullscreen_screen) {
				window_set_size( 0.75*display_get_width(), 0.75*display_get_height() )
				window_set_position( 100, 100 )
			}
			
			ini_open("settings")
			ini_write_real( "video", "fullscreen_screen", global.settings.fullscreen_screen )
			ini_write_real( "video", "borderless_screen", global.settings.borderless_screen )
			ini_write_real( "video", "vsync", global.settings.vsync )
			ini_write_real( "video", "postprocessing", global.settings.postprocessing )
			ini_close()
			break
		
		case (2):
			ini_open("settings")
			ini_write_real( "camera", "camera_smoothness", global.settings.camera_smoothness )
			ini_write_real( "camera", "camera_mouse_influence", global.settings.camera_mouse_influence )
			ini_write_real( "camera", "camera_shaking", global.settings.camera_shaking )
			ini_write_real( "camera", "camera_zoom_speed", global.settings.camera_zoom_speed )
			ini_close()
			break
	}
}
