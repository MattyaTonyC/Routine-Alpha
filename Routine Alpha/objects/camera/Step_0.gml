//
if (instance_exists(menu_ingame)) if (menu_ingame.pause_menu) exit

var mx_prop = window_mouse_get_x() / window_get_width()
var my_prop = window_mouse_get_y() / window_get_height()

var target_x = target.x + camera_get_view_width(cam.id)/2 * global.settings.camera_mouse_influence * (mx_prop-0.5)
var target_y = target.y + camera_get_view_height(cam.id)/2 * global.settings.camera_mouse_influence * (my_prop-0.5)

x += (target_x - x) / max( 20*global.settings.camera_smoothness, 1 )
y += (target_y - y) / max( 20*global.settings.camera_smoothness, 1 )

with (cam) {
	if (mouse_check_button_pressed(mb_middle)) size_return = true
	
	if (mouse_wheel_down()) {
		if (size_return) size_target = size
		size_target += 0.1
		size_return = false
	}
	if (mouse_wheel_up()) {
		if (size_return) size_target = size
		size_target -= 0.1
		size_return = false
	}
	size_target = clamp( size_target, 0.5, 2 )
	
	if (size_return) size_target = 1
	size += sign(size_target-size) * min( abs(size_target-size), (global.settings.camera_zoom_speed+0.2)/12 )
	if (size == size_target) size_return = false
	
	camera_set_view_size( id, size*w_orig, size*h_orig )
	camera_set_view_pos( id, other.x-camera_get_view_width(id)/2, other.y-camera_get_view_height(id)/2 )
}
