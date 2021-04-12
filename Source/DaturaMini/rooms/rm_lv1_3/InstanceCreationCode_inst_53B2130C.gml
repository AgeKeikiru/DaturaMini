fn_trigger = function(){
	
	fc1();
	
}

fc1 = function(){

	fc_next = fc2;
	fc_delay = 0.1;
	
	scr_place(obj_conflyer, x + (8 * -4), y + (8 * 9));

}

fc2 = function(){

	scr_place(obj_conflyer, x + (8 * 8), y + (8 * 5));
	instance_destroy();
	
}