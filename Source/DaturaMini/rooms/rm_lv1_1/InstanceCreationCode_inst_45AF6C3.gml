fn_trigger = function(){
	
	scr_place(obj_slime, x + (8 * 8), y + (8 * 4));
	scr_place(obj_conflyer, x + (8 * -8), y + (8 * 0));
	scr_place(obj_conflyer, x + (8 * 10), y + (8 * 1));
	
	instance_destroy();
	
}