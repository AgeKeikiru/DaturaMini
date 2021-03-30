fn_trigger = function(){

	fc1();

}

fc1 = function(){

	fc_next = fc2;
	fc_delay = 0.3;
	
	startNim();

}

fc2 = function(){

	fc_next = fc3;
	fc_delay = 1.5;
	
	var _ele = getTagged("elevator3")[0];
	
	with _ele{
	
		spd_y = -1;
	
	}

}

fc3 = function(){

	with obj_ui{
	
		fc_segment_fadeOut_1();
	
	}
	
	instance_destroy();

}