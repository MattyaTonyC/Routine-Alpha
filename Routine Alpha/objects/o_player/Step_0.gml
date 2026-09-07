//
var input = { x:0, y:0, dis:0, dir:0, run:false }
if (transition.target == noone) && (!vehicle_mode) with (input) {
	x = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	y = keyboard_check(ord("S")) - keyboard_check(ord("W"))
	dis = min( point_distance( 0,0, x,y ), 1 )
	dir = point_direction( 0,0, x,y )
	run = keyboard_check(vk_shift)
}

var target_spd = { x:0, y:0, dis:0, dir:0 }
target_spd.x = (spd_max+input.run*spd_run) * lengthdir_x( input.dis,input.dir )
target_spd.y = (spd_max+input.run*spd_run) * lengthdir_y( input.dis,input.dir )
target_spd.dis = min( point_distance( spd.x,spd.y, target_spd.x,target_spd.y ), acc )
target_spd.dir = point_direction( spd.x,spd.y, target_spd.x,target_spd.y )

spd.x += lengthdir_x( target_spd.dis, target_spd.dir )
spd.y += lengthdir_y( target_spd.dis, target_spd.dir )

var collision = []
array_copy( collision,0, global.collision_list,0, array_length(global.collision_list) )
array_push( collision, layer_tilemap_get_id("Walls") )
move_and_collide( spd.x,spd.y, collision )

spd.x = sign(spd.x) * min( abs(x-xprevious), abs(spd.x) )
spd.y = sign(spd.y) * min( abs(y-yprevious), abs(spd.y) )
