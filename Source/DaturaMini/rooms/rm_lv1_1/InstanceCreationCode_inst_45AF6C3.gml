fn_trigger = function(){
	
	fc1();
	
}

fc1 = function(){

	fc_next = fc2;
	fc_delay = 0.1;
	
	scr_place(obj_slime, x + (8 * 8), y + (8 * 4));

}

fc2 = function(){

	fc_next = fc3;
	fc_delay = 0.1;
	
	scr_place(obj_conflyer, x + (8 * -8), y + (8 * 0));

}

fc3 = function(){

	scr_place(obj_conflyer, x + (8 * 10), y + (8 * 1));
	instance_destroy();

}