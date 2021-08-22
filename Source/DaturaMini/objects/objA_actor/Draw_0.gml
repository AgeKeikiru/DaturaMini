
warnBeam_draw();

var
_a = 1;

if(iFrames > 0 && (current_time mod room_speed) > (room_speed / 2)){
	_a = 0.5;
}

if(sprite_index != noone){
	
	var _col = image_blend;
	
	if(stun > 0){
	    _col = sp_frozen ? c_aqua : c_red;
	}
	
	if(object_index == obj_player && en < 1){
    	_col = merge_color(c_blue, c_white, abs(sin(current_time / 60)) * 0.5);
    }
	
	//note: do not apply sprite shake to Y axis
	draw_sprite_ext(sprite_index, -1, x + s_shake, y, image_xscale, image_yscale, image_angle + deadspin, _col, _a);
	
	s_shake = -lerp(s_shake, 0, 0.2);
	
}