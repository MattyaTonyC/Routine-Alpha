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

//
if (instance_exists(o_zone)) {
	var player_zone = noone
	with (o_zone) {
		if (position_meeting( o_player.x,o_player.y, id )) {
			player_zone = group
			break
		}
	}
	with (o_zone) if (group == player_zone) {
		visible = true
	}
	
	//
	var tm_w = layer_tilemap_get_id("Walls")
	var tm_f = layer_tilemap_get_id("Floors")
	
	with (o_zone) {
		var list = ds_list_create()
		var num = instance_place_list( x,y, o_door, list, false )
		for (var i=0; i<num; i++) {
			array_push( list[|i].zone_groups, group )
		}
		ds_list_destroy(list)
		
		if (visible) continue
		
		var ds_list = ds_list_create()
		var num = instance_place_list( x,y, all, ds_list, false);
		for (var i=0; i<num; i++) {
			with (ds_list[|i]) if (object_index != o_zone) visible = false
		}
		ds_list_destroy(ds_list)
		
		var cell_x0 = tilemap_get_cell_x_at_pixel( tm_w, bbox_left+5, bbox_top )
		var cell_x1 = tilemap_get_cell_x_at_pixel( tm_w, bbox_right-5, bbox_top )
		var cell_y0 = tilemap_get_cell_y_at_pixel( tm_w, bbox_left, bbox_top+5 )
		var cell_y1 = tilemap_get_cell_y_at_pixel( tm_w, bbox_left, bbox_bottom-5 )
		for (var iy=cell_y0; iy<=cell_y1; iy++) {
			for (var ix=cell_x0; ix<=cell_x1; ix++) {
				var data_w = tilemap_get( tm_w, ix, iy )
				var data_f = tilemap_get( tm_f, ix, iy )
				var ind_w = tile_get_index(data_w)
				var ind_f = tile_get_index(data_f)
				
				if (ind_w >= 3) && (ind_w != 524287) {
					data_w = tile_set_index( data_w, 16*((ind_w-4) div 16) + 5 + 4 )
					tilemap_set( tm_w, data_w, ix,iy )
				}
				
				if (ind_f mod 2 == 0) || (ind_f == 0) continue
				data_f = tile_set_index( data_f, ind_f +1 )
				tilemap_set( tm_f, data_f, ix,iy )
			}
		}
	}
	with (o_zone) {
		if (!visible) continue
		
		var ds_list = ds_list_create()
		var num = instance_place_list( x,y, all, ds_list, false);
		for (var i=0; i<num; i++) {
		   with (ds_list[|i]) if (object_index != o_zone) visible = true
		}
		ds_list_destroy(ds_list)
		
		var cell_x0 = tilemap_get_cell_x_at_pixel( tm_w, bbox_left+5, bbox_top )
		var cell_x1 = tilemap_get_cell_x_at_pixel( tm_w, bbox_right-5, bbox_top )
		var cell_y0 = tilemap_get_cell_y_at_pixel( tm_w, bbox_left, bbox_top+5 )
		var cell_y1 = tilemap_get_cell_y_at_pixel( tm_w, bbox_left, bbox_bottom-5 )
		var player_ts = { x:tilemap_get_cell_x_at_pixel( tm_w, o_player.x, o_player.y ), y:tilemap_get_cell_y_at_pixel( tm_w, o_player.x, o_player.y ) }
		
		for (var iy=cell_y0; iy<=cell_y1; iy++) {
			for (var ix=cell_x0; ix<=cell_x1; ix++) {
				var data_w = tilemap_get( tm_w, ix, iy )
				var data_f = tilemap_get( tm_f, ix, iy )
				var ind_w = tile_get_index(data_w)
				var ind_f = tile_get_index(data_f)
				
				if (ind_w >= 3) && (ind_w != 524287) {
					var pos = 4
					var neighbors = { x:0, y:0 }
					
					if (ix < player_ts.x) {
						pos --
						var temp_ind = tile_get_index(tilemap_get(tm_w,ix+1,iy))
						if (temp_ind > 3) && (temp_ind != 524287) neighbors.x = 1
					}
					if (ix > player_ts.x) {
						pos ++
						var temp_ind = tile_get_index(tilemap_get(tm_w,ix-1,iy))
						if (temp_ind > 3) && (temp_ind != 524287) neighbors.x = -1
					}
					if (iy < player_ts.y) {
						pos -= 3
						var temp_ind = tile_get_index(tilemap_get(tm_w,ix,iy+1))
						if (temp_ind > 3) && (temp_ind != 524287) neighbors.y = 1
					}
					if (iy > player_ts.y) {
						pos += 3
						var temp_ind = tile_get_index(tilemap_get(tm_w,ix,iy-1))
						if (temp_ind > 3) && (temp_ind != 524287) neighbors.y = -1
					}
					
					var target_side = "dev"
					var dir = 0
					switch (pos) {
						case (1): case (3): case (5): case (7):
							target_side = "roof"
							if (neighbors.x == 0) && (neighbors.y == 0) target_side = "side"
							
							dir = 90 * (pos div 3)
							if (pos == 3) dir = 270
							break
						
						default:
							target_side = "side"
							if (neighbors.x != 0) && (neighbors.y != 0) {
								target_side = "corner"
								var temp_ind = tile_get_index(tilemap_get(tm_w,ix+neighbors.x,iy+neighbors.y))
								if (temp_ind > 3) && (temp_ind != 524287) target_side = "roof"
							}
							if (neighbors.x == 0) && (neighbors.y == 0) target_side = "ledge"
							
							dir = 90 * (pos div 2)
							if (pos == 8) dir = 180
							if (pos == 0) && (neighbors.x == 0) && (neighbors.y != 0) dir = 270
							if (pos == 2) && (neighbors.x != 0) && (neighbors.y == 0) dir = 0
							if (pos == 8) && (neighbors.x == 0) && (neighbors.y != 0) dir = 90
							if (pos == 6) && (neighbors.x != 0) && (neighbors.y == 0) dir = 180
							break
					}
					
					if (tile_get_rotate(data_w)) dir -= 90
					if (tile_get_mirror(data_w) || tile_get_flip(data_w)) dir -= 180
					if (dir < 0) dir += 360
					
					var side_arr = [9,9,9,9]
					switch (target_side) {
						case ("side"): side_arr = [14, 8, 1, 7]; break
						case ("corner"): side_arr = [13, 4, 2, 11]; break
						case ("ledge"): side_arr = [15, 12, 0, 3]; break
						case ("roof"): side_arr = [10, 6, 10, 6]; break
					}
					var target_ind = side_arr[dir div 90]
					
					data_w = tile_set_index( data_w, 16*((ind_w-4) div 16) + target_ind + 4 )
					tilemap_set( tm_w, data_w, ix,iy )
				}
				
				if (ind_f mod 2 != 0) || (ind_f == 0) continue
				data_f = tile_set_index( data_f, ind_f - 1 )
				tilemap_set( tm_f, data_f, ix,iy )
			}
		}
	}
}
