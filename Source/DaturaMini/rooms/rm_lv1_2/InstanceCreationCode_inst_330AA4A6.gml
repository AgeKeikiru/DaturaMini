lst_spawn = ds_list_create();
phase = 0;
origin = [x + (8 * 2), y];

#region //phase 1

	fcA1 = function(){

		fc_next = fcA2;
		fc_delay = 0.1;
	
		var _new = scr_place(obj_conflyer, origin[0] + (8 * 8), origin[1] + (8 * 2));
		ds_list_add(lst_spawn, _new);
		_new.image_xscale = -1;

	}

	fcA2 = function(){

		fc_next = fcA3;
		fc_delay = 0.1;
	
		var _new = scr_place(obj_conflyer, origin[0] + (8 * 4), origin[1] + (8 * 1));
		ds_list_add(lst_spawn, _new);
		_new.image_xscale = -1;

	}

	fcA3 = function(){

		fc_next = fcA4;
		fc_delay = 0.1;
	
		ds_list_add(lst_spawn, scr_place(obj_conflyer, origin[0] + (8 * 0), origin[1] + (8 * 0)));
	
	}

	fcA4 = function(){

		fc_next = fcA5;
		fc_delay = 0.1;
	
		ds_list_add(lst_spawn, scr_place(obj_conflyer, origin[0] + (8 * -4), origin[1] + (8 * 1)));

	}

	fcA5 = function(){

		ds_list_add(lst_spawn, scr_place(obj_conflyer, origin[0] + (8 * -8), origin[1] + (8 * 2)));

	}

#endregion

#region //phase 2

	fcB1 = function(){

		fc_next = fcB2;
		fc_delay = 0.1;
		
		origin[1] += 8 * 6;
		
		var _new = scr_place(obj_slime, origin[0] + (8 * 8), origin[1]);
		ds_list_add(lst_spawn, _new);
		_new.image_xscale = -1;

	}

	fcB2 = function(){

		fc_next = fcB3;
		fc_delay = 0.1;
	
		ds_list_add(lst_spawn, scr_place(obj_slime, origin[0] + (8 * -8), origin[1]));

	}

	fcB3 = function(){

		fc_next = fcB4;
		fc_delay = 0.1;
	
		var _new = scr_place(obj_slime, origin[0] + (8 * 6), origin[1]);
		ds_list_add(lst_spawn, _new);
		_new.image_xscale = -1;
	
	}

	fcB4 = function(){

		ds_list_add(lst_spawn, scr_place(obj_slime, origin[0] + (8 * -6), origin[1]));

	}

#endregion

fc_end = function(){

	obj_player.cam_xTgt = -1;
	obj_player.cam_yTgt = -1;
					
	ds_list_destroy(lst_spawn);
					
	var _arr = getTagged("wall1");
					
	for(var _i = 0; _i < array_length(_arr); _i++){
						
		instance_destroy(_arr[_i]);
						
	}
					
	instance_destroy();

}

fn_trigger = function(){
	
	obj_player.cam_xTgt = x + -obj_player.x + (8 * 3);
	obj_player.cam_yTgt = y;
	
	var
	_left = getTagged("1left")[0],
	_right = getTagged("1right")[0];
	
	_left.image_yscale = _right.image_yscale;
	
}

fn_whileActive = function(){
	
	var _clear = true;
			
	for(var _i = 0; _i < ds_list_size(lst_spawn); _i++){
			
		var _o = lst_spawn[| _i];
				
		if(instance_exists(_o)){ _clear = false; }
			
	}
	
	if(fc_delay <= 0 && _clear){
	
		ds_list_clear(lst_spawn);
		
		switch(phase++){
	
			case 0:
		
				fc_next = fcA1;
				fc_delay = 0.4;
		
				break;
			
			case 1:
		
				fc_next = fcB1;
				fc_delay = 0.4;
			
				break;
			
			default:
		
				fc_next = fc_end;
				fc_delay = 0.6;
			
				break;
	
		}
	
	}
	
}