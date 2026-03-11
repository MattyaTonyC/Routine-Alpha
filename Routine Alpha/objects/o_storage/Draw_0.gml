//
draw_self()

if (is_open) {
	//draw_rectangle( x-sprite_width/2-1,y-sprite_height/2-1, x+sprite_width/2+1,y+sprite_height/2+1, true )
	draw_line_width( x-sprite_width/2-1,y-sprite_height/2-0.75, x+sprite_width/2+1,y-sprite_height/2-0.75, 0.5 )
	draw_line_width( x-sprite_width/2-1,y+sprite_height/2+0.75, x+sprite_width/2+1,y+sprite_height/2+0.75, 0.5 )
	draw_line_width( x-sprite_width/2-0.75,y-sprite_height/2-0.75, x-sprite_width/2-0.75,y+sprite_height/2+0.75, 0.5 )
	draw_line_width( x+sprite_width/2+0.75,y-sprite_height/2-0.75, x+sprite_width/2+0.75,y+sprite_height/2+0.75, 0.5 )
}
is_open = false
