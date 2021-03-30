fn_trigger = function(){
	
	fc1();
	
}

fc1 = function(){

	fc_next = fc2;
	fc_delay = 0.1;
	
	scr_place(obj_conflyer, x + (8 * 4), y + (8 * 2));

}

fc2 = function(){

	fc_next = fc3;
	fc_delay = 0.1;
	
	scr_place(obj_conflyer, x + (8 * 9), y + (8 * 1));

}

fc3 = function(){

	scr_place(obj_conflyer, x + (8 * 14), y + (8 * 2));
	instance_destroy();
	
}