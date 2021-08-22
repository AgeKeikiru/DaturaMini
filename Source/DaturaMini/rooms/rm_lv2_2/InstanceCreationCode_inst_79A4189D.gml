fn_trigger = function(){
	
	getTagged("54door")[0].spd_y = -1;
	
	getTagged("258lift")[0].spd_y = -2;
	getTagged("258lift")[0].moveBounds[1] += 8 * -25;
	getTagged("258lift")[0].moveBounds[3] += 8 * 2;
	
}