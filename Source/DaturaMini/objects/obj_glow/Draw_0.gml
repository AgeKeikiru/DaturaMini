draw_set_color(image_blend);

var _len = array_length(arr_trail);

for(var _i = 0; _i < _len; _i++){
	
	draw_set_alpha((1 + -(_i / _len)) * 0.3);
	
	draw_circle(arr_trail[_i][0], arr_trail[_i][1], (size / 2) * (1 + -(_i / _len)), false);
	
}

if(live){

	draw_set_color(c_white);
	draw_set_alpha(1);

	draw_circle(x, y, size, false);

	draw_set_color(image_blend);
	draw_set_alpha(0.4);

	draw_circle(x, y, size + 1, false);

}

draw_set_color(c_white);
draw_set_alpha(1);