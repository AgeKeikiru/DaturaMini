fn_trigger = function(){
	
	scr_place(obj_slime, x + (8 * 8), y + (8 * 11));
	scr_place(obj_slime, x + (8 * 19), y + (8 * 10));
	scr_place(obj_conflyer, x + (8 * 10), y + (8 * 16));
	scr_place(obj_conflyer, x + (8 * 1), y + (8 * 12));
	scr_place(obj_conflyer, x + (8 * 14), y + (8 * 6));
	
	instance_destroy();
	
}