fn_trigger = function(){

	var
	_shutter = getTagged("ele1_shutter")[0],
	_wall = getTagged("ele1_wall")[0],
	_ele = getTagged("ele1");
	
	_wall.y += 8 * -10;
	
	with _shutter{
	
		moveBounds[2] += (8 * 4);
		oneWay = true;
		spd_x = 1;
	
	}
	
	for(var _i = 0; _i < array_length(_ele); _i++){
	
		with _ele[_i]{
		
			moveBounds[1] += (8 * -10) + 1;
			oneWay = true;
			spd_y = -1;
		
		}
	
	}
	
	instance_destroy();

}