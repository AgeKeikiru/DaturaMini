drawMask();

if(aggro_w >= 1 && aggro_h >= 1 && checkDebugView()){

	draw_set_color(c_red);
	
	var _box = fn_getAggroRect();
	
	draw_rectangle(_box.x1, _box.y1, _box.x2, _box.y2, true);
	
	draw_set_color(c_white);

}