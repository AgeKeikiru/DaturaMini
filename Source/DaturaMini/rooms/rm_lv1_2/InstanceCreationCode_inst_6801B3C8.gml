lst_spawn = ds_list_create();
arr_wave1kills = array_create(6, false);
phase = 0;
origin = [x + (8 * -10), y + (8 * -14)];

fn_trigger = function(){

	fcA1();

}

fn_whileActive = function(){

	var _end = true;
	
	for(var _i = 0; _i < ds_list_size(lst_spawn); _i++){
	
		var _o = lst_spawn[| _i];
		
		if(instance_exists(_o)){
			_end = false;
		}else if(_i < array_length(arr_wave1kills) && !arr_wave1kills[_i]){
		
			arr_wave1kills[_i] = true;
			
			if(_i < 4){
			
				ds_list_add(lst_spawn, scr_place(obj_conflyer, x + ((4 + _i) * 8), y + -((7 + (_i mod 2)) * 8)));
			
			}else{
			
				ds_list_add(lst_spawn, scr_place(obj_slime, x + -((2 + _i) * 8), y + -(7 * 8)));
			
			}
		
		}
	
	}
	
	if(_end && ds_list_size(lst_spawn) > 4){
	
		fc_end();
	
	}

}

fc_end = function(){

	obj_player.cam_xTgt = -1;
	obj_player.cam_yTgt = -1;
					
	ds_list_destroy(lst_spawn);
					
	instance_destroy(getTagged("wall2")[0]);
					
	instance_destroy();

}

fcA1 = function(){

	fc_next = fcA2;
	fc_delay = 0.3;
	
	var
	_side = getTagged("ele2_sideWall")[0],
	_top = getTagged("ele2_topWall")[0];
	
	_side.y += 8 * -6;
	
	instance_destroy(_top);
	
	startNim();

}

fcA2 = function(){

	fc_next = fcA3;
	fc_delay = 1.5;
	
	var _ele = getTagged("elevator2")[0];
	
	with _ele{
	
		moveBounds[1] += (8 * -8) + 1;
		oneWay = true;
		spd_y = -1;
	
	}

}

fcA3 = function(){

	obj_player.cam_xTgt = x + -obj_player.x + (8 * -2);
	obj_player.cam_yTgt = y + (8 * -10);
	
	endNim();
	fcB1();

}

fcB1 = function(){

	fc_delay = 0.05;
	
	if(ds_list_size(lst_spawn) < 4){
	
		var
		_r = 20,
		_x = origin[0] + lengthdir_x(_r, 90 * ds_list_size(lst_spawn)),
		_y = origin[1] + lengthdir_y(_r, 90 * ds_list_size(lst_spawn));
		
		ds_list_add(lst_spawn, scr_place(obj_conflyer, _x, _y));
	
	}else if(ds_list_size(lst_spawn) < 6){
	
		origin = [x + (8 * 8), y + (8 * -11)];
		
		ds_list_add(lst_spawn, scr_place(obj_slime, origin[0] + (32 * (ds_list_size(lst_spawn) + -5)), origin[1]));
	
	}else{
		fc_delay = -1;
	}

}