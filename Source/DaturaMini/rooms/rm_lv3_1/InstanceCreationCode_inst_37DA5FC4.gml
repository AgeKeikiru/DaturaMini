fn_trigger = function(){

	fc1();

}

fc1 = function(){

	fc_next = fc2;
	fc_delay = 0.5;
	
	obj_player.image_xscale = 1;
	
	startNim();

}

fc2 = function(){

	fc_next = fc3;
	fc_delay = 1.5;
	
	instance_destroy(getTagged("endwall")[0]);
	
	with obj_player{
	
		input_lock = true;
		input_x = 1;
		force_y = -6;
	
	}

}

fc3 = function(){

	with obj_ui{
	
		fc_segment_fadeOut_1();
	
	}
	
	instance_destroy();

}