fn_trigger = function(){
	
	fc1();
	
}

fc1 = function(){

	fc_next = fc2;
	fc_delay = 0.1;
	
	with scr_place(obj_lily, x + (8 * 2), y + (8 * -6)){
	
		image_angle = 180;
	
	}

}

fc2 = function(){

	fc_next = fc3;
	fc_delay = 0.1;
	
	scr_place(obj_lily, x + (8 * 15), y + (8 * 4));

}

fc3 = function(){

	fc_next = fc4;
	fc_delay = 0.1;
	
	scr_place(obj_conflyer, x + (8 * -5), y + (8 * 2));

}

fc4 = function(){

	fc_next = fc5;
	fc_delay = 0.1;
	
	scr_place(obj_conflyer, x + (8 * -2), y + (8 * 1));

}

fc5 = function(){

	fc_next = fc6;
	fc_delay = 0.1;
	
	scr_place(obj_conflyer, x + (8 * 5), y + (8 * 1));

}

fc6 = function(){

	scr_place(obj_conflyer, x + (8 * 8), y + (8 * 2));
	instance_destroy();
	
}