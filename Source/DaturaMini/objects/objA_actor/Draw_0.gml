var
_a = 1;

if(iFrames > 0 && (current_time mod room_speed) > (room_speed / 2)){
	_a = 0.5;
}

if(sprite_index != noone){
	
	var _col = c_white;
	
	if(stun > 0){
	    _col = sp_frozen ? c_aqua : c_red;
	}
	
	draw_sprite_ext(sprite_index, -1, x, y, image_xscale, image_yscale, image_angle + deadspin, _col, _a);
	
}