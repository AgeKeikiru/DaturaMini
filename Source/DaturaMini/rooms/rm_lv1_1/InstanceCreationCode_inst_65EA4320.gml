fn_trigger = function(){
	
	scr_place(obj_slime, x + (8 * -17), y + (8 * 8));
	scr_place(obj_slime, x + (8 * -5), y + (8 * -4));
	scr_place(obj_conflyer, x + (8 * -11), y + (8 * 3));
	scr_place(obj_conflyer, x + (8 * -4), y + (8 * 9));
	scr_place(obj_conflyer, x + (8 * -12), y + (8 * -5));
	
	instance_destroy();
	
}