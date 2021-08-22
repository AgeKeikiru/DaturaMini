
event_inherited();

xOff = 0;
yOff = 0;

direction = -90;

atkLoop = 0;
atkWait = 0;

visible = true;
sprite_index = noone;
mask_index = spr_cb_trigger;

intf_warnBeam_implement();

fn_trigger = function(){
	//override
	
	atkLoop = 0;
	atkWait = -0.6;
	
	arr_warns[0] = new lwo_warningBeam(x + xOff, y + yOff, direction);
	
}

fn_whileActive = function(){
	//override
	
	atkWait += TICK * global.timeFlow;
	
	if(atkLoop < 10 && atkWait > 0.05){
	    
	    if(atkLoop == 0){
	        arr_warns = [];
	    }
	    
	    atkLoop++;
	    atkWait = 0;
	    
	    var
	    _force = 4,
	    _scale = 3,
	    _o = scr_place(obj_eAtk_fireball, x + xOff, y + yOff);
		
		_o.image_xscale = _scale;
		_o.image_yscale = _scale;
		_o.pv_x = lengthdir_x(_force, direction);
		_o.pv_y = lengthdir_y(_force, direction);
	    
	}else if(atkWait > 2){
	    
	    active = false;
	    
	}
	
}

fn_clear = function(){
	//override
}