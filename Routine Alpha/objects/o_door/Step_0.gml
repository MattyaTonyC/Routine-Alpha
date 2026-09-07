//
var tm = layer_tilemap_get_id("Walls")
var ptx = tilemap_get_cell_x_at_pixel( tm, o_player.x, o_player.y )
var pty = tilemap_get_cell_y_at_pixel( tm, o_player.x, o_player.y )
var tx = tilemap_get_cell_x_at_pixel( tm, x, y )
var ty = tilemap_get_cell_y_at_pixel( tm, x, y )
if (image_angle < 0) image_angle += 360

image_index = 1
image_yscale = 1

switch (image_angle) {
	case (0):
		if (is_open) {
			image_index ++
			if (ptx >= tx) image_index ++
		}
		else if (o_player.y < y) image_yscale = -1
		break
	
	case (90):
		if (is_open) {
			image_index ++
			if (pty <= ty) image_index ++
		}
		else if (o_player.x < x) image_yscale = -1
		break
	
	case (180):
		if (is_open) {
			image_index ++
			if (ptx <= tx) image_index ++
		}
		else if (o_player.y > y) image_yscale = -1
		break
	
	case (270):
		if (is_open) {
			image_index ++
			if (pty >= ty) image_index ++
		}
		else if (o_player.x > x) image_yscale = -1
		break
}
