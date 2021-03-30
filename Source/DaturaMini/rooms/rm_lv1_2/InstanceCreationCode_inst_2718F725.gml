fn_trigger = function(){
	
	fc1();
	
}

fc1 = function(){

	fc_next = fc2;
	fc_delay = 0.1;
	
	scr_place(obj_slime, x + (8 * -7), y + (8 * 2));

}

fc2 = function(){

	fc_next = fc3;
	fc_delay = 0.1;
	
	with scr_place(obj_slime, x + (8 * 3), y + (8 * 2)){
	
		image_xscale = -1;
	
	}

}

fc3 = function(){

	scr_place(obj_conflyer, x + (8 * -11), y + (8 * -1));
	instance_destroy();
	
}