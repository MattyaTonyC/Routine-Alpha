//
if (menu_ingame.pause_menu) exit

var mx_prop = window_mouse_get_x() / window_get_width()
var my_prop = window_mouse_get_y() / window_get_height()

var target_x = o_player.x + camera_get_view_width(cam_id)/2 * global.settings.camera_mouse_influence * (mx_prop-0.5)
var target_y = o_player.y + camera_get_view_height(cam_id)/2 * global.settings.camera_mouse_influence * (my_prop-0.5)

x += (target_x - x) / max( 20*global.settings.camera_smoothness, 1 )
y += (target_y - y) / max( 20*global.settings.camera_smoothness, 1 )

camera_set_view_pos( cam_id, x-camera_get_view_width(cam_id)/2, y-camera_get_view_height(cam_id)/2 )
