event_inherited();

if(checkDebugView()){

	var
	_camX = camera_get_view_x(view_camera[0]),
	_camY = camera_get_view_y(view_camera[0]);

	player = true;

	draw_set_font(ft_small);
	draw_set_color(c_black);

	draw_text(_camX + 2, _camY + 2,
		"onGround: " + string(on_ground()) +
		"\nspd_x: " + string(spd_x) +
		"\nx: " + string(x) +
		"\ncam_x: " + string(cam_x)
	);

	draw_set_color(c_white);

}