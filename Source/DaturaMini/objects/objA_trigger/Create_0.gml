intf_flowchart_implement();

#macro SPAWN_DELAY 0.1
#macro SPAWN_WAVE_DELAY 0.6

spawnTime = 0;

arr_toSpawn = [[]];

lst_spawn = ds_list_create();

camOff = [0, 0];

wallTag = "";

screenLock = false;

fn_spawn = function(_spawn){
    
    ds_list_add(lst_spawn, scr_place(_spawn.obj, x + (_spawn.xOff * 8), y + (_spawn.yOff * 8)));
    
}

fn_centerCam = function(){
    
    obj_player.cam_xTgt = x + -obj_player.x + (8 * camOff[0]);
	obj_player.cam_yTgt = y + (8 * camOff[1]);
    
}

fnA_trigger = function(){
    //abstract
}

fn_trigger = function(){
	
	spawnTime = 0.1;
	
	if(screenLock){
	
	    instance_destroy(obj_enemy, false);
	    
	    fn_centerCam();
	    
	    spawnTime = SPAWN_WAVE_DELAY;
	
	}
	
	fnA_trigger();
	
}

fnA_whileActive = function(){
    //abstract
}

fn_whileActive = function(){
	
	var _clear = true;
			
	for(var _i = 0; _i < ds_list_size(lst_spawn); _i++){
			
		var _o = lst_spawn[| _i];
				
		if(instance_exists(_o)){ _clear = false; }
			
	}
	
	if(spawnTime > 0){
	    
	    spawnTime += -TICK;
	    
	    if(spawnTime <= 0){
	        
	        if(array_length(arr_toSpawn)){
        	    
        	    if(array_length(arr_toSpawn[0])){
        	        
        	        spawnTime = SPAWN_DELAY;
        	        
        	        fn_spawn(arr_toSpawn[0][0]);
        	        array_delete(arr_toSpawn[0], 0, 1);
        	        
        	    }else{
        	        
        	        spawnTime = 0.1;
        	        array_delete(arr_toSpawn, 0, 1);
        	        
        	    }
        	    
        	}else{
        	    
        	    fn_clear();
        	    
        	}
	        
	    }
	    
	}
	
	if(!_clear && (!array_length(arr_toSpawn) || !array_length(arr_toSpawn[0]))){
	    spawnTime = SPAWN_WAVE_DELAY;
	}
	
	fnA_whileActive();
	
}

fnA_clear = function(){
    //abstract
}

fn_clear = function(){
    
    if(screenLock){
    
        obj_player.cam_xTgt = -1;
    	obj_player.cam_yTgt = -1;
    	
    	ds_list_destroy(lst_spawn);
    	
    	var _arr = getTagged(wallTag);
    					
    	for(var _i = 0; _i < array_length(_arr); _i++){
    						
    		instance_destroy(_arr[_i]);
    						
    	}
	
    }
	
	fnA_clear();
	
	instance_destroy();
    
}

active = false;

visible = checkDebugView();