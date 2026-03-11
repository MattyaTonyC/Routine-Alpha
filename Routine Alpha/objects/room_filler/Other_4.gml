//
with (o_room_entrance) {
	if (entrance == global.entrance) {
		var inst = instance_create_layer( x,y, "Player", o_player )
		if (global.inventory != noone) inst.inventory = global.inventory
		
		camera.x = o_player.x
		camera.y = o_player.y
		break
	}
}
