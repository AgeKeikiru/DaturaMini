#macro TICK (1 / room_speed)
#macro SAVE_LOC program_directory + "SAV"

global.debugView = false;

function saveData(){
        
    if(file_exists(SAVE_LOC)){
        file_delete(SAVE_LOC);
    }
    
    var _f = file_text_open_write(SAVE_LOC);
    
    file_text_write_string(_f, ds_map_write(global.map_save));
    
    file_text_close(_f);
    
    show_debug_message("saving to " + SAVE_LOC);
    
}

function loadData(){
    
    if(file_exists(SAVE_LOC)){
        
        show_debug_message("loading " + SAVE_LOC);
        
        var
        _f = file_text_open_read(SAVE_LOC),
        _map_load = ds_map_create();
        
        ds_map_read(_map_load, file_text_read_string(_f));
        
        if(_map_load[? en_save.VERSION] == SAVE_VERSION){
        
            ds_map_copy(global.map_save, _map_load);
        
        }else{
            
            show_debug_message("LOAD FAIL: VERSION MISMATCH");
            
        }
    
        file_text_close(_f);
        
        ds_map_destroy(_map_load);
        
    }
    
}

function array_peek(_arr){
    
    return _arr[array_length(_arr) + -1];
    
}

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
			force_y = -max(abs(_lift) + weight, abs(force_y)) * sign(_lift);
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

function keyToString(_key){
    
    /*//
    Script by D.W. O'Boyle (@dwoboyle)
    How to use:
    Simply call this script in a draw_text function. 
    argument0 should be a keyboard key such as vk_enter or ord('Z').
    //*/
    
    if(_key > 48 && _key < 91){ return chr(_key); }
    
    switch(_key){
        
        case 8:     return "Bksp"; break;
        case 9:     return "Tab"; break;
        case 13:    return "Enter"; break;
        case 16:    return "Shift"; break;
        case 17:    return "Ctrl"; break;
        case 18:    return "Alt"; break;
        //case 19:    return "Pause"; break;
        case 20:    return "CAPS"; break;
        //case 27:    return "Esc"; break;
        case 32:    return "Space"; break;
        //case 33:    return "PgUp"; break;
        //case 34:    return "PgDn"; break;
        //case 35:    return "End"; break;
        //case 36:    return "Home"; break;
        case 37:    return "Left"; break;
        case 38:    return "Up"; break;
        case 39:    return "Right"; break;
        case 40:    return "Down"; break;
        //case 45:    return "Ins"; break;
        //case 46:    return "Del"; break;
        case 96:    return "Num0"; break;
        case 97:    return "Num1"; break;
        case 98:    return "Num2"; break;
        case 99:    return "Num3"; break;
        case 100:   return "Num4"; break;
        case 101:   return "Num5"; break;
        case 102:   return "Num6"; break;
        case 103:   return "Num7"; break;
        case 104:   return "Num8"; break;
        case 105:   return "Num9"; break;
        case 106:   return "Num*"; break;
        case 107:   return "Num+"; break;
        case 109:   return "Num-"; break;
        case 110:   return "Num."; break;
        case 111:   return "Num/"; break;
        //case 112:   return "F1"; break;
        //case 113:   return "F2"; break;
        //case 114:   return "F3"; break;
        //case 115:   return "F4"; break;
        //case 116:   return "F5"; break;
        //case 117:   return "F6"; break;
        //case 118:   return "F7"; break;
        //case 119:   return "F8"; break;
        //case 120:   return "F9"; break;
        //case 121:   return "F10"; break;
        //case 122:   return "F11"; break;
        //case 123:   return "F12"; break;
        case 144:   return "NumLk"; break;
        //case 145:   return "ScrLk"; break;
        case 186:   return ";"; break;
        case 187:   return "="; break;
        case 188:   return ","; break;
        case 189:   return "-"; break;
        case 190:   return "."; break;
        case 191:   return "\\"; break;
        case 192:   return "`"; break;
        case 219:   return "/"; break;
        case 220:   return "["; break;
        case 221:   return "]"; break;
        case 222:   return "'"; break;
        default:    return ""; break;
        
    }
    
}

function joyToString(_joy){
    
    switch(_joy){
        
        case gp_face1:      return "(A)"; break;
        case gp_face2:      return "(B)"; break;
        case gp_face3:      return "(X)"; break;
        case gp_face4:      return "(Y)"; break;
        case gp_shoulderl:  return "(LB)"; break;
        case gp_shoulderlb: return "(LT)"; break;
        case gp_shoulderr:  return "(RB)"; break;
        case gp_shoulderrb: return "(RT)"; break;
        case gp_select:     return "(SE)"; break;
        case gp_start:      return "(ST)"; break;
        case gp_padu:       return "(UP)"; break;
        case gp_padd:       return "(DOWN)"; break;
        case gp_padl:       return "(LEFT)"; break;
        case gp_padr:       return "(RIGHT)"; break;
        case gp_stickl:     return "(LS)"; break;
        case gp_stickr:     return "(RS)"; break;
        default:            return ""; break;
        
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
    
    function audf_playSfx(_sfx, _gain){
        
        with obj_ui{
        
            if(is_undefined(_gain)){
                _gain = global.map_save[? en_save.SET_SFX];
            }
            
            var
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