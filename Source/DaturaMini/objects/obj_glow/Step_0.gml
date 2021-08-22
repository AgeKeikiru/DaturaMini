var
_subtrail = 2,
_lastPos = arr_trail[0];

if(live){

	for(var _i = 0; _i <= _subtrail; _i++){

		array_insert(
			arr_trail,
			0,
			[
				lerp(_lastPos[0], x, _i / _subtrail),
				lerp(_lastPos[1], y, _i / _subtrail)
			]
		);

	}

	if(array_length(arr_trail) > trailMax){
		array_resize(arr_trail, trailMax);
	}

}else{
	
	if(array_length(arr_trail) > 1){
		array_resize(arr_trail, array_length(arr_trail) + -1);
	}else{
		instance_destroy();
	}
	
}