//
cam = { id:view_camera[0], w_orig:320, h_orig:180, size_target:1, size:1, size_return:false }
target = o_player

if (room == r_house) {
	cam.w_orig /= 2
	cam.h_orig /= 2
}
