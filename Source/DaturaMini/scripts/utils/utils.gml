#macro TICK (1 / room_speed)

global.debugView = false;

function checkDebugView(){
	return global.debugView xor debug_mode;
}

function scr_approach(_start, _tgt, _amt){

	if(_start > _tgt){
		return max(_start + -_amt, _tgt);
	}else{
		return min(_start + _amt, _tgt);
	}

}

function takeDmg(_inst, _dmg, _push, _lift, _stun, _iFrames){
	
	if(is_undefined(_push)){ _push = 3; }
	if(is_undefined(_lift)){ _lift = 2; }
	if(is_undefined(_stun)){ _stun = 0.3; }
	if(is_undefined(_iFrames)){ _iFrames = 0; }
		
	with(_inst){
			
		if(!player){
			image_xscale = (x > obj_player.x) ? -1 : 1;
		}
		
		hp += -_dmg;
		iFrames = _iFrames;
		
		if(!armored){
		
			stun = max(stun, _stun);
			input_lock = false; //if stunned during an attack, remove lock to prevent infinite lock
			
			force_x = -image_xscale * _push;
			spd_x = 0;
			force_y = -(_lift + weight);
			spd_y = 0;
		
		}
		
		if(stun > 0){
			
			sprite_index = s_idle;
			animate = false;
			
			switchState(noone);
			
		}
		
		state_current = method(undefined, pstate_air);
		
		if(hp <= 0 && object_is_ancestor(object_index, obj_enemy)){ switchState(fn_state_dead); }
			
	}
	
}

function styleTxt(_txt, _x, _y, _col, _sCol){

	if(is_undefined(_col)){ _col = c_white; }
	if(is_undefined(_sCol)){ _sCol = c_dkgray; }
	
	var _cc = draw_get_color();

	draw_set_color(_sCol);

	draw_text(_x + -1, _y, _txt);
	draw_text(_x, _y + 1, _txt);
	draw_text(_x + -1, _y + 1, _txt);
	
	draw_set_color(_col);

	draw_text(_x, _y, _txt);
	
	draw_set_color(_cc);

}

function shakeCam(_x, _y){
	
	if(global.hyperActive){
	
		_x *= 2;
		_y *= 2;
	
	}
	
	with obj_player{
		
		cam_shakeX += _x * image_xscale;
		cam_shakeY += _y;
		
	}
	
}

function addAct(_src){
		
	var _o = scr_place(obj_actState);
		
	_o.src = _src;
		
	return _o;
		
}

function addHyper(_amt){
    
    if(global.hyperActive){
        _amt *= 2;
    }
    
    global.hyper = clamp(global.hyper + _amt, 0, 1);
    
}

function endHyper(){
    
    global.hyperActive = false;
    global.hyper = 0;
    global.hyperChain = 0;
    
    instance_destroy(global.hyperAfterImg);
    
}

function startNim(){ //non-interactive mode
    
    with obj_player{
        
        switchState(noone);
        input_lock = true;
        input_x = 0;
        input_y = 0;
        iState = true;
        
    }
    
    with obj_ui{
        
        uiOffset[1] = 1;
        
    }
    
    with objA_pAtk{
        
        if(id != global.hyperAfterImg){
            
            instance_destroy();
            
        }
        
    }
    
}

function endNim(){
    
    with obj_player{
        
        input_lock = false;
        iState = false;
        
    }
    
    with obj_ui{
        
        uiOffset[1] = 0;
        
    }
    
}