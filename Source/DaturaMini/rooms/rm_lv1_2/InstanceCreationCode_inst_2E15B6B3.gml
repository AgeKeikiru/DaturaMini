fn_trigger = function(){
	
	fc1();
	
}

fc1 = function(){

	fc_next = fc2;
	fc_delay = 0.1;
	
	scr_place(obj_slime, x + (8 * 8), y + (8 * 8));

}

fc2 = function(){

	fc_next = fc3;
	fc_delay = 0.1;
	
	scr_place(obj_conflyer, x + (8 * 7), y + (8 * -1));

}

fc3 = function(){

	fc_next = fc4;
	fc_delay = 0.1;
	
	scr_place(obj_conflyer, x + (8 * 9), y + (8 * -7));

}

fc4 = function(){

	scr_place(obj_slime, x + (8 * 17), y + (8 * -6));
	instance_destroy();
	
}