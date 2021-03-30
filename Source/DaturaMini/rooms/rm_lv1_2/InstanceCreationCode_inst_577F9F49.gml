fn_trigger = function(){

	var _ele = getTagged("elevator1")[0];
	
	with _ele{
	
		moveBounds[3] += 8 * 18;
		oneWay = true;
		spd_y = 1;
	
	}
	
	instance_destroy();

}