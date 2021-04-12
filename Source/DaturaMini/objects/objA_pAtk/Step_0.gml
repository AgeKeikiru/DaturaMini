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

if(collision_rectangle(bbox_left + -1, bbox_top + -1, bbox_right + 1, bbox_bottom + 1, objA_solid, false, true) && !passWall){
    instance_destroy();
}