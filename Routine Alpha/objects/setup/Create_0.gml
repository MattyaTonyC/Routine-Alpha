//
instance_create_layer( 0,0, "System", transition )
instance_create_layer( 0,0, "System", music_handler )

switch (room) {
	case (r_game_launch):
		instance_create_layer( 0,0, "System", menu_game_launch )
		break
	
	case (r_menu_main):
		instance_create_layer( 0,0, "System", menu_main )
		break
	
	case (r_game_end):
		game_end()
		break
	
	default:
		instance_create_layer( 0,0, "System", menu_ingame )
		instance_create_layer( 0,0, "System", room_filler )
		instance_create_layer( 0,0, "System", camera )
		instance_create_layer( 0,0, "System", draw_manager )
		break
}
