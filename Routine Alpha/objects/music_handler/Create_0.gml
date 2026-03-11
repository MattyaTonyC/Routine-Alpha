//
audio_stop_all()

room_theme = noone
switch (room) {
	case (r_menu_main): room_theme = mus_main_menu_theme; break
	case (r_house): room_theme = mus_house_theme; break
	case (r_city): room_theme = mus_city_theme; break
}
