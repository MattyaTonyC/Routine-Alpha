/// СТЕНЫ
var tm = layer_tilemap_get_id("Walls")

player_ts.xprev = player_ts.x
player_ts.yprev = player_ts.y
player_ts.x = tilemap_get_cell_x_at_pixel( tm, o_player.x, o_player.y )
player_ts.y = tilemap_get_cell_y_at_pixel( tm, o_player.x, o_player.y )

if (player_ts.x != player_ts.xprev) || (player_ts.y != player_ts.yprev) {
	var iy_rad = 30
	var ix_rad = 50
	for (var iy=-iy_rad; iy<=iy_rad; iy++) {
		if (player_ts.x == player_ts.xprev) {
			if (iy == -iy_rad+1) {
				iy = -2
				continue
			}
			if (iy == 2) {
				iy = iy_rad-1
				continue
			}
		}
		for (var ix=-ix_rad; ix<=ix_rad; ix++) {
			if (player_ts.y == player_ts.yprev) {
				if (ix == -ix_rad+1) {
					ix = -2
					continue
				}
				if (ix == 2) {
					ix = ix_rad-1
					continue
				}
			}
			
			var cell_x = player_ts.x + ix
			var cell_y = player_ts.y + iy
			var data = tilemap_get( tm, cell_x, cell_y )
			var ind = tile_get_index(data)
			if (ind <= 3) || (ind == 524287) || ((ind-4) mod 16 == 5) continue
			
			// позиция относительно игрока:
			// 0 1 2
			// 3 4 5
			// 6 7 8
			var pos = 4
			var neighbors = { x:0, y:0 }
			
			if (cell_x < player_ts.x) {
				pos --
				var temp_ind = tile_get_index(tilemap_get(tm,cell_x+1,cell_y))
				if (temp_ind > 3) && (temp_ind != 524287) neighbors.x = 1
			}
			if (cell_x > player_ts.x) {
				pos ++
				var temp_ind = tile_get_index(tilemap_get(tm,cell_x-1,cell_y))
				if (temp_ind > 3) && (temp_ind != 524287) neighbors.x = -1
			}
			if (cell_y < player_ts.y) {
				pos -= 3
				var temp_ind = tile_get_index(tilemap_get(tm,cell_x,cell_y+1))
				if (temp_ind > 3) && (temp_ind != 524287) neighbors.y = 1
			}
			if (cell_y > player_ts.y) {
				pos += 3
				var temp_ind = tile_get_index(tilemap_get(tm,cell_x,cell_y-1))
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
						var temp_ind = tile_get_index(tilemap_get(tm,cell_x+neighbors.x,cell_y+neighbors.y))
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
			
			if (tile_get_rotate(data)) dir -= 90
			if (tile_get_mirror(data) || tile_get_flip(data)) dir -= 180
			if (dir < 0) dir += 360
			
			var side_arr = [9,9,9,9]
			switch (target_side) {
				case ("side"): side_arr = [14, 8, 1, 7]; break
				case ("corner"): side_arr = [13, 4, 2, 11]; break
				case ("ledge"): side_arr = [15, 12, 0, 3]; break
				case ("roof"): side_arr = [10, 6, 10, 6]; break
			}
			var target_ind = side_arr[dir div 90]
			
			data = tile_set_index( data, 16*((ind-4) div 16) + target_ind + 4 )
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

//
with (select_inst) {
	var w = 10*(abs(sprite_width) div 10) / 2
	var h = 10*(abs(sprite_height) div 10) / 2
	var t = current_time/10
	draw_set_colour(make_colour_hsv( 100, 100, 90 + abs(180 - (t mod 360)) )); draw_set_alpha(0.2)
	draw_rectangle( x-w-0.75, y-h-0.75, x+w+0.75, y+h+0.75, false )
	draw_line_width( x-w-1, y-h-0.75, x+w+1,y-h-0.75, 0.5 )
	draw_line_width( x-w-1, y+h+0.75, x+w+1,y+h+0.75, 0.5 )
	draw_line_width( x-w-0.75, y-h-0.5, x-w-0.75,y+h+0.5, 0.5 )
	draw_line_width( x+w+0.75, y-h-0.5, x+w+0.75,y+h+0.5, 0.5 )
	draw_set_colour(c_white); draw_set_alpha(1)
}
select_inst = noone
