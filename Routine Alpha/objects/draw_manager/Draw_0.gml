/// СТЕНЫ
var tm = layer_tilemap_get_id("Walls")

player_ts.xprev = player_ts.x
player_ts.yprev = player_ts.y
player_ts.x = tilemap_get_cell_x_at_pixel( tm, o_player.x, o_player.y )
player_ts.y = tilemap_get_cell_y_at_pixel( tm, o_player.x, o_player.y )

if (player_ts.x != player_ts.xprev) || (player_ts.y != player_ts.yprev) {
	for (var iy=-wall_dis; iy<=wall_dis; iy++) {
		for (var ix=-wall_dis; ix<=wall_dis; ix++) {
			var cell_x = player_ts.x + ix
			var cell_y = player_ts.y + iy
			
			var data = tilemap_get( tm, cell_x, cell_y )
			var ind = tile_get_index(data)
			if (ind <= 0) continue
			
			// 0 1 2
			// 3 4 5
			// 6 7 8
			var pos = 4
			var neighbors = { x:0, y:0 }
			
			if (cell_x < player_ts.x) {
				pos --
				if (tile_get_index(tilemap_get(tm,cell_x+1,cell_y)) != 0) neighbors.x = 1
			}
			if (cell_x > player_ts.x) {
				pos ++
				if (tile_get_index(tilemap_get(tm,cell_x-1,cell_y)) != 0) neighbors.x = 1
			}
			if (cell_y < player_ts.y) {
				pos -= 3
				if (tile_get_index(tilemap_get(tm,cell_x,cell_y+1)) != 0) neighbors.y = 1
			}
			if (cell_y > player_ts.y) {
				pos += 3
				if (tile_get_index(tilemap_get(tm,cell_x,cell_y-1)) != 0) neighbors.y = 1
			}
			
			var target_ind = 1
			var dir = 0
			switch (pos) {
				case (1): case (3): case (5): case (7):
					if (neighbors.x == 0) && (neighbors.y == 0) target_ind = 3
					
					dir = 90 * (pos div 3)
					if (pos == 3) dir = 270
					break
				
				default:
					target_ind = 3
					if (neighbors.x == 1) && (neighbors.y == 1) target_ind = 2
					if (neighbors.x == 0) && (neighbors.y == 0) target_ind = 4
					
					dir = 90 * (pos div 2)
					if (pos == 8) dir = 180
					if (pos == 0) && (neighbors.x == 0) && (neighbors.y == 1) dir = 270
					if (pos == 2) && (neighbors.x == 1) && (neighbors.y == 0) dir = 0
					if (pos == 8) && (neighbors.x == 0) && (neighbors.y == 1) dir = 90
					if (pos == 6) && (neighbors.x == 1) && (neighbors.y == 0) dir = 1800
					break
			}
			data = tile_set_mirror( data, false )
			data = tile_set_flip( data, false )
			data = tile_set_rotate( data, false )
			if (dir >= 180) {
				data = tile_set_mirror( data, true )
				data = tile_set_flip( data, true )
			}
			if (dir mod 180 == 90) data = tile_set_rotate( data, true )
			
			data = tile_set_index( data, 5*(ind div 5) + target_ind )
			tilemap_set( tm, data, cell_x,cell_y )
		}
	}
}

/// ФОН
layer_x( "Background_Par1", layer_get_x("Background_Par1") + 0.02 )
layer_y( "Background_Par1", layer_get_y("Background_Par1") - 0.01 )

layer_x( "Background_Par2", layer_get_x("Background_Par2") - 0.05 )
layer_y( "Background_Par2", layer_get_y("Background_Par2") - 0.05 )

layer_x( "Background_Par3", layer_get_x("Background_Par3") + 0.01 )
layer_y( "Background_Par3", layer_get_y("Background_Par3") + 0.1 )
