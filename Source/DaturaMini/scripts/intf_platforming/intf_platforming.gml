function intf_platforming_implement(){

	spd_x = 0; //velocity values
	spd_y = 0;
	spdInt_x = 0;
	spdInt_y = 0;
	spdFrac_x = 0;
	spdFrac_y = 0;
	
	//movement boundaries, used for moving platforms
	//left, top, right, bottom
	moveBounds = [x, y, x, y];
	
	lst_coll = ds_list_create(); //multiple collision list

}

function drawMask(){

	if(mask_index != noone && checkDebugView()){

		draw_set_color(c_fuchsia);
	
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
	
		draw_set_color(c_white);

	}

}

function collCheck(_xdir, _ydir, _obj, _list){
		
	if(is_undefined(_obj)){ _obj = obj_cb_wall; }
	if(is_undefined(_list)){ _list = false; }

	if(!_list){
		return collision_rectangle(bbox_left + _xdir, bbox_top + _ydir, bbox_right + _xdir, bbox_bottom + _ydir, _obj, false, true);
	}else{
		
		ds_list_clear(lst_coll);
		
		return collision_rectangle_list(bbox_left + _xdir, bbox_top + _ydir, bbox_right + _xdir, bbox_bottom + _ydir, _obj, false, true, lst_coll, false);
		
	}
		
}
		
function on_wall(){

	return collision_rectangle(bbox_left, bbox_bottom + 1, bbox_right, bbox_bottom + 1, obj_cb_wall, false, true);

}

function on_slope(){

	return collision_point(x, bbox_bottom + 1, obj_cb_slope, true, true);

}
		
function on_passThru(){
		
	var
	//DO NOT replace with collCheck, results in strange behavior when multiple passThru objects are vertically close
	_on = collision_rectangle(bbox_left, bbox_bottom + 1, bbox_right, bbox_bottom + 1, obj_cb_passThru, false, true),
	_in = collision_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom, obj_cb_passThru, false, true);

	if(!_on){ return noone; }

	if(!_in){ return _on; }

	if(_on == _in){ return noone; }
	
	return _on;
		
}

function on_ground(){
	
	return on_wall() || on_slope() || on_passThru();
	
}
		
function roundSpd(){
		
	//needed to keep track of fractional speed values
		
	spdFrac_x += spd_x;
	spdInt_x = floor(spdFrac_x);
	spdFrac_x -= spdInt_x;

	spdFrac_y += spd_y;
	spdInt_y = floor(spdFrac_y);
	spdFrac_y -= spdInt_y;
		
}
		
function move_x(_amt, _slope, _inst){
		
	if(is_undefined(_amt)){ _amt = 0; } //amount to move
	if(is_undefined(_slope)){ _slope = false; } //can this travel across slopes?
	if(is_undefined(_inst)){ _inst = self; } //what instance to move
			
	var _xdir = sign(_amt);
			
	with(_inst){
			  
		repeat(abs(_amt)){
				  
			if(!collCheck(_xdir, 0)){
						
				x += _xdir;

				if(_slope && !move_slope(_xdir)){
					return false; // We couldn't move on a slope
				}
				  
			}else{
				return false; // If we collided with something, return 0
			}
					
		}
			  
	}

	return true;
		
}

function platMove_x(_amt){

	var
	_xdir = sign(_amt),
	passThru = object_is_ancestor(object_index, obj_cb_passThru);
	
	repeat(abs(_amt)){
	    
		// Colliding with solid
	    if(collCheck(_xdir, 0)){ return false; }
		
		//push
		var _num = collCheck(_xdir, 0, objA_actor, true);
		
		for(var _i = 0; _i < _num; _i++){
		
			var _obj = lst_coll[| _i];
			
			if(!passThru && !move_x(_xdir, true, _obj)){ return false; }
		
		}
		
		//carry
		_num = collCheck(0, -1, objA_actor, true);
		
		for(var _i = 0; _i < _num; _i++){
		
			var _obj = lst_coll[| _i];
			
			if(!(passThru && collCheck(0, 0, _obj))){
				move_x(_xdir, true, _obj);
			}
			
		}

	    // Finally move        
	    x += _xdir;
		
		//change direction when reaching movement boundaries
		if(moveBounds[0] != moveBounds[2]){
			
			if(x < moveBounds[0]){ spd_x = abs(spd_x); }
			if(x > moveBounds[2]){ spd_x = -abs(spd_x); }
			
		}
	}

	return true;

}
		
function move_y(_amt, _inst){
		
	if(is_undefined(_amt)){ _amt = 0; } //amount to move
	if(is_undefined(_inst)){ _inst = self; } //what instance to move
			
	var _ydir = sign(_amt);
			
	with(_inst){
				
		repeat(abs(_amt)){
					
			//falling
			if(_ydir){
			            
				if(!on_ground()){
			        y += _ydir;
			    }else{
			        return 0;
				}
						
			}else{ //rising
			            
				if(!collCheck(0, _ydir)){
			        y += _ydir;
			    }else{
			        return 0;
				}
						
			}
					
		}
				
	}

	return true;
		
}

function platMove_y(_amt){

	var
	_ydir = sign(_amt),
	passThru = object_is_ancestor(object_index, obj_cb_passThru),
	_actorPush = collCheck(0, _ydir, objA_actor),
	_actorPull = collCheck(0, -_ydir, objA_actor);

	repeat(abs(_amt)){
	    
		// Colliding with solid
	    if(collCheck(0, _ydir)){ return false; }

		var _num;
		
		//falling
		if(_ydir){
		
			//push
			_num = collCheck(0, _ydir, objA_actor, true);
			
			for(var _i = 0; _i < _num; _i++){
		
				var _obj = lst_coll[| _i];
			
				if(!passThru && _obj && !move_y(_ydir, _obj)){ return false; } //exit if actor is squished
		
			}
			
			//pull
			_num = collCheck(0, -1, objA_actor, true);
			
			instance_deactivate_object(self); //prevent collision with this object
		
			for(var _i = 0; _i < _num; _i++){
		
				var _obj = lst_coll[| _i];
			
				move_y(_ydir, _obj);
			
			}
			
			instance_activate_object(self);
		
		}else{ //rising
		
			//push
			_num = collCheck(0, _ydir, objA_actor, true);
			
			for(var _i = 0; _i < _num; _i++){
		
				var _obj = lst_coll[| _i];
			
				if(!(passThru && collCheck(0, 0, _obj)) && _obj && !move_y(_ydir, _obj)){ return false; } //exits if actor is squished
		
			}
		
		}

	    // If everything went good, move
	    y += _ydir;
		
		//change direction when reaching movement boundaries
		if(moveBounds[1] != moveBounds[3]){
			
			if(y < moveBounds[1]){ spd_y = abs(spd_y); }
			if(y > moveBounds[3]){ spd_y = -abs(spd_y); }
			
		}
		
	}

	return true;

}
		
function move_slope(_xdir){
		
	// Inside a slope (must go up)
	if(collision_point(x, y - 1, obj_cb_slope, true, true)){
			    
		// If we cannot move up, we must go back.
		if(!move_y(-1)){
					
			x -= _xdir;
			return false;
					
		}
				
	}

	// On a slope going down
	if(!on_ground() && collision_point(x, y + 1, obj_cb_slope, true, true)){
		move_y(1);
	}

	return true;
		
}