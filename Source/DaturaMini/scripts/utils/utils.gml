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
			
		if(!player && !armored){
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
			switchState(noone);
			
		}
		
		if(boss && bossStun > BOSS_STUNMAX){
		    
            force_x = -image_xscale * 3;
			spd_x = 0;
			force_y = -2;
			spd_y = 0;
			
			bossStun = 0;
			
			sprite_index = s_idle;
			switchState(fn_state_stun1);
		    
		}
		
		state_current = method(undefined, pstate_air);
		
		if(hp <= 0 && object_is_ancestor(object_index, obj_enemy)){ switchState(fn_state_dead); }
			
	}
	
}

function styleTxt(_txt, _x, _y, _col, _sCol, _fullStroke){

	if(is_undefined(_col)){ _col = c_white; }
	if(is_undefined(_sCol)){ _sCol = c_dkgray; }
	if(is_undefined(_fullStroke)){ _fullStroke = false; }
	
	var _cc = draw_get_color();

	draw_set_color(_sCol);
	
	if(_fullStroke){
	    
	    draw_text(_x + 1, _y, _txt);
    	draw_text(_x, _y + -1, _txt);
    	draw_text(_x + 1, _y + -1, _txt);
	    
	}

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
    
    global.nim = true;
    
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
    
    global.nim = false;
    
    with obj_player{
        
        input_lock = false;
        iState = false;
        
    }
    
    with obj_ui{
        
        uiOffset[1] = 0;
        
    }
    
}

#region //audio functions

    function audf_playBgm(_bgm){
        
        with obj_ui{
        
            var _gain = global.map_save[? en_save.SET_BGM];
            
            if(audio_get_name(bgmCurr) != audio_get_name(_bgm)){
            
                audio_stop_sound(bgmCurr);
                
                bgmCurr = audio_play_sound(_bgm, 999, true);
                
                audio_sound_gain(bgmCurr, _gain, 0);
            
            }
        
        }
        
    }
    
    function audf_playSfx(_sfx){
        
        with obj_ui{
        
            var
            _gain = global.map_save[? en_save.SET_SFX],
            _maxSounds = 60,
            _copies = 0;
            
            if(ds_map_exists(global.map_soundMix, _sfx)){
                _gain *= global.map_soundMix[? _sfx];
            }
            
            //check if max number of same sound is already playing
            for(var _i = 0; _i < ds_list_size(lst_sfx); _i++){
                
                var _check = lst_sfx[| _i];
                
                if(audio_get_name(_check) == audio_get_name(_sfx) && audio_is_playing(_check)){
                    
                    _copies++;
                    
                    if(_copies > 3){
                        audio_stop_sound(_check);
                    }
                    
                }
                
            }
            
            var _s = audio_play_sound(_sfx, 0, false);
        
            audio_sound_gain(_s, _gain, 0);
            
            ds_list_insert(lst_sfx, 0, _s);
            
            while(ds_list_size(lst_sfx) > _maxSounds){
                
                audio_stop_sound(lst_sfx[| _maxSounds]);
                
                ds_list_delete(lst_sfx, _maxSounds);
                
            }
        
        }
        
    }

#endregion