event_inherited();

if(!instance_exists(lockOn)){
	
	delay += -global.timeFlow / room_speed;
	
	spd = lerp(spd, 0, 0.2);
	
	if(delay <= 0){
		
		lockOn = instance_find(obj_player, 0);
		
	}
	
}else{

	var
	_dist = point_direction(x, y, lockOn.x, lockOn.y + -6),
	_angle = dsin(_dist + -direction),
	_turn = 12;

	if(_angle > 0){
		direction += _turn;
	}else if(_angle < 0){
		direction += -_turn;
	}
	
	spd = lerp(spd, 4 * room_speed, 0.2);

	// Set speed
	//x = x + (dcos(direction) * velocity);
	//y = y - (dsin(direction) * velocity);

}

speed = (spd * global.timeFlow) / room_speed;

if(collision_point(x, y, obj_player, false, true)){

	if(live){

		live = false;
	
		contact();

	}

}