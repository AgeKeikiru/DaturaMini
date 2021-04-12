fn_trigger = function(){
	
	fc1();
	
}

fc1 = function(){

	fc_next = fc2;
	fc_delay = 0.1;
	
	scr_place(obj_slime, x + (8 * -10), y + (8 * 7));

}

fc2 = function(){

	scr_place(obj_lily, x + (8 * -18), y + (8 * 6));
	instance_destroy();
	
}