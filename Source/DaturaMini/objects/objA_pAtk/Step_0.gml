event_inherited();

if(duration > 0){
	
	duration += -global.timeFlow;
	
	if(duration <= 0){ instance_destroy(); }
	
}

if(pv_d != 0){
	speed = pv_d * global.timeFlow;
}else{
	
	hspeed = pv_x * global.timeFlow;
	vspeed = pv_y * global.timeFlow;
	
}