fn_trigger = function(){
	
	var
	_hatches = getTagged("852hatch"),
	_left = getTagged("852left"),
	_right = getTagged("852right");
	
	for(var _i = 0; _i < array_length(_hatches); _i++){
	
		instance_destroy(_hatches[_i]);
		
		if(_i < array_length(_left)){
			
			_left[_i].spd_x = -1;
			_right[_i].spd_x = 1;
			
		}
	
	}
	
}