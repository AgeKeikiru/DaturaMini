//spawn 3 lilies, each one killed spawns a set of enemies

lst_spawn = ds_list_create();
phase = 0;
origin = [x + (8 * 2), y];
arr_lilyWave = [false, false, false];

#region //phase 1

	fcA1 = function(){

		fc_next = fcA2;
		fc_delay = 0.1;
	
		var _new = scr_place(obj_lily, x + (8 * -7), y + (8 * 8));
		ds_list_add(lst_spawn, _new);
		
	}

	fcA2 = function(){

		fc_next = fcA3;
		fc_delay = 0.1;
	
		var _new = scr_place(obj_lily, x + (8 * 4), y + (8 * -6));
		ds_list_add(lst_spawn, _new);
		
		_new.image_angle = 180;

	}

	fcA3 = function(){

		var _new = scr_place(obj_lily, x + (8 * 15), y + (8 * 8));
		ds_list_add(lst_spawn, _new);
	
	}

#endregion

#region //phase 2

	fcB1 = function(){

		fc_next = fcB2;
		fc_delay = 0.1;
		
		var _new = scr_place(obj_slime, x + (8 * -8), y + (8 * 7));
		ds_list_add(lst_spawn, _new);

	}

	fcB2 = function(){

		fc_next = fcB3;
		fc_delay = 0.1;
	
		var _new = scr_place(obj_slime, x + (8 * 0), y + (8 * 7));
		ds_list_add(lst_spawn, _new);

	}

	fcB3 = function(){

		var _new = scr_place(obj_slime, x + (8 * 5), y + (8 * 4));
		ds_list_add(lst_spawn, _new);

	}

#endregion

#region //phase 3

	fcC1 = function(){

		fc_next = fcC2;
		fc_delay = 0.1;
		
		var _new = scr_place(obj_conflyer, x + (8 * -6), y + (8 * 0));
		ds_list_add(lst_spawn, _new);

	}

	fcC2 = function(){

		fc_next = fcC3;
		fc_delay = 0.1;
	
		var _new = scr_place(obj_conflyer, x + (8 * -4), y + (8 * -2));
		ds_list_add(lst_spawn, _new);

	}
	
	fcC3 = function(){

		fc_next = fcC4;
		fc_delay = 0.1;
	
		var _new = scr_place(obj_conflyer, x + (8 * -4), y + (8 * 2));
		ds_list_add(lst_spawn, _new);

	}
	
	fcC4 = function(){

		fc_next = fcC5;
		fc_delay = 0.1;
	
		var _new = scr_place(obj_conflyer, x + (8 * 14), y + (8 * 0));
		ds_list_add(lst_spawn, _new);

	}
	
	fcC5 = function(){

		fc_next = fcC6;
		fc_delay = 0.1;
	
		var _new = scr_place(obj_conflyer, x + (8 * 12), y + (8 * -2));
		ds_list_add(lst_spawn, _new);

	}

	fcC6 = function(){

		var _new = scr_place(obj_conflyer, x + (8 * 12), y + (8 * 2));
		ds_list_add(lst_spawn, _new);

	}

#endregion

#region //phase 4

	fcD1 = function(){

		fc_next = fcD2;
		fc_delay = 0.1;
		
		var _new = scr_place(obj_slime, x + (8 * 16), y + (8 * 7));
		ds_list_add(lst_spawn, _new);

	}

	fcD2 = function(){

		fc_next = fcD3;
		fc_delay = 0.1;
	
		var _new = scr_place(obj_slime, x + (8 * 8), y + (8 * 7));
		ds_list_add(lst_spawn, _new);

	}

	fcD3 = function(){

		var _new = scr_place(obj_slime, x + (8 * 3), y + (8 * 4));
		ds_list_add(lst_spawn, _new);

	}

#endregion

fc_end = function(){

	obj_player.cam_xTgt = -1;
	obj_player.cam_yTgt = -1;
					
	ds_list_destroy(lst_spawn);
					
	var _arr = getTagged("endWall");
					
	for(var _i = 0; _i < array_length(_arr); _i++){
						
		instance_destroy(_arr[_i]);
						
	}
					
	instance_destroy();

}

fn_trigger = function(){
	
	instance_destroy(obj_enemy, false);
	
	fc_next = fcA1;
	fc_delay = 0.3;
	
	obj_player.cam_xTgt = x + -obj_player.x + (8 * 4);
	obj_player.cam_yTgt = y;
	
	var
	_left = getTagged("endLeft")[0],
	_right = getTagged("endRight")[0];
	
	_left.image_yscale = _right.image_yscale;
	
}

fn_whileActive = function(){
	
	var _clear = true;
			
	for(var _i = 0; _i < ds_list_size(lst_spawn); _i++){
			
		var _o = lst_spawn[| _i];
				
		if(instance_exists(_o)){
			_clear = false;
		}else if(_i < 3 && !arr_lilyWave[_i] && fc_delay <= 0){
			
			arr_lilyWave[_i] = true;
			
			switch _i{
			
				case 0:
					fcB1();
					break;
					
				case 1:
					fcC1();
					break;
					
				case 2:
					fcD1();
					break;
			
			}
			
		}
			
	}
	
	if(_clear && fc_delay <= 0 && ds_list_size(lst_spawn) > 5){
	
		fc_next = fc_end;
		fc_delay = 0.6;
	
	}
	
}