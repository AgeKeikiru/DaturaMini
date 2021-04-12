fn_trigger = function(){
	
	fc1();
	
}

fc1 = function(){

	fc_next = fc2;
	fc_delay = 0.1;
	
	scr_place(obj_lily, x + (8 * -12), y + (8 * 1));

}

fc2 = function(){

	fc_next = fc3;
	fc_delay = 0.1;
	
	scr_place(obj_slime, x + (8 * -4), y + (8 * 0));

}

fc3 = function(){

	fc_next = fc4;
	fc_delay = 0.1;
	
	scr_place(obj_slime, x + (8 * 4), y + (8 * 0));

}

fc4 = function(){

	fc_next = fc5;
	fc_delay = 0.1;
	
	scr_place(obj_conflyer, x + (8 * -6), y + (8 * -5));

}

fc5 = function(){

	scr_place(obj_conflyer, x + (8 * 8), y + (8 * -3));
	instance_destroy();
	
}