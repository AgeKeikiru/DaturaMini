var
_a = 1;

if(iFrames > 0 && (current_time mod room_speed) > (room_speed / 2)){
	_a = 0.5;
}

if(sprite_index != noone){
	draw_sprite_ext(sprite_index, -1, x, y, image_xscale, 1, image_angle, (stun > 0) ? c_red : c_white, _a);
}