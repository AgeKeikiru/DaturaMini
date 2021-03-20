event_inherited();

if(!instance_exists(lockOn)){
	
	lockOn = collision_circle(x, y, 40, obj_enemy, false, true);
	
}else{

	var
	_dist = point_direction(x, y, lockOn.x, lockOn.y),
	_angle = dsin(_dist + -direction),
	_turn = 4;

	if(_angle > 0){
		direction += _turn;
	}else if(_angle < 0){
		direction += -_turn;
	}

	// Set speed
	//x = x + (dcos(direction) * velocity);
	//y = y - (dsin(direction) * velocity);

}

var _snap = 15;

//image_angle = round(direction / _snap) * _snap;
image_angle = direction;