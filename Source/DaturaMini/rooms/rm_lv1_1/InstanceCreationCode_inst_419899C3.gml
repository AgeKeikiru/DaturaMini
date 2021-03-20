fn_trigger = function(){
	
	scr_place(obj_slime, x + (8 * 6), y + (8 * 4));
	scr_place(obj_slime, x + (8 * 8), y + (8 * 9));
	scr_place(obj_slime, x + (8 * 17), y + (8 * 3));
	scr_place(obj_conflyer, x + (8 * 5), y + (8 * -2));
	scr_place(obj_conflyer, x + (8 * 23), y + (8 * 0));
	
	instance_destroy();
	
}