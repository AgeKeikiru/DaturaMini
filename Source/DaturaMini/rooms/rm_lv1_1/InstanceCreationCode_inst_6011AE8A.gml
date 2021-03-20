timer = 0;

lst_spawn = ds_list_create();

fn_trigger = function(){
	
	obj_player.cam_xTgt = x + -obj_player.x + -30;
	obj_player.cam_yTgt = y + 80;
	
}

fn_whileActive = function(){
	
	var _clear = true;
			
	for(var _i = 0; _i < ds_list_size(lst_spawn); _i++){
			
		var _o = lst_spawn[| _i];
				
		if(instance_exists(_o)){ _clear = false; }
			
	}
	
	switch(ds_list_size(lst_spawn)){
	
		case 0:
		
			timer += TICK;
	
			if(timer > 0.4){
		
				ds_list_add(lst_spawn, scr_place(obj_conflyer, x + 30, y + 90));
				timer = 0;
		
			}
		
			break;
			
		case 1:
		
			if(_clear){
				
				timer += TICK;
				
				if(timer > 0.4){
				
					ds_list_add(lst_spawn, scr_place(obj_conflyer, x + -80, y + 105));
					timer = 0;
				
				}
				
			}
			
			break;
			
		default:
		
			if(_clear){
				
				timer += TICK;
				
				if(timer > 0.6){
				
					obj_player.cam_xTgt = -1;
					obj_player.cam_yTgt = -1;
					
					ds_list_destroy(lst_spawn);
					
					var _arr = getTagged("dropWall");
					
					for(var _i = 0; _i < array_length(_arr); _i++){
						
						instance_destroy(_arr[_i]);
						
					}
					
					instance_destroy();
				
				}
				
			}
			
			break;
	
	}
	
}