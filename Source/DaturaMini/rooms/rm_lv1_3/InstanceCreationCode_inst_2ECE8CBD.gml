fn_trigger = function(){
	
	fc1();
	
}

fc1 = function(){

	fc_next = fc2;
	fc_delay = 0.1;
	
	with scr_place(obj_lily, x + (8 * 3), y + (8 * -4)){
	
		image_angle = 180;
	
	}

}

fc2 = function(){

	fc_next = fc3;
	fc_delay = 0.1;
	
	scr_place(obj_slime, x + (8 * 8), y + (8 * 8));

}

fc3 = function(){

	scr_place(obj_slime, x + (8 * -4), y + (8 * 8));
	
	instance_destroy();
	
}