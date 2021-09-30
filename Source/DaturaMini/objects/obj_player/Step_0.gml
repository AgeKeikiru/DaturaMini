event_inherited();

#region //hazard collision

    var
    _num = collCheck(0, 0, objA_actor, true),
    _hit = false;
    
    if(collision_rectangle(bbox_left + -1, bbox_top + -1, bbox_right + 1, bbox_bottom + 1, obj_cb_hazard, false, true) != noone && !global.nim){
        _hit = true;
    }
    
    for(var _i = 0; _i < _num; _i++){
    
    	var _obj = lst_coll[| _i];
    
    	if(_obj.hazard){
    		_hit = true;
    	}
    
    }
    
    if(_hit && iFrames <= 0 && !iState){
    
		var
		_push = 3,
		_lift = 2,
		_stun = 0.3,
		_if = _stun * 3;
		
		if((blocking && en >= 1) || currPly.podMerged){
			
			useEn(1);
			
			_push = 2;
			_lift = 0;
			_stun = 0;
			
			if(currPly.podMerged){
			    
			    with currPly{
			        fn_forceSplit();
			    }
			    
			    useEn(99);
			    
			}
			
		}else{
			
			loseHp();
			shakeCam(choose(3, -3), choose(3, -3));
			
			global.timeFlow = 0.4;
			global.timeSlow = 0.5;
			
		}
	
		takeDmg(self, 0, _push, _lift, _stun, _if);

	}

#endregion

#region //en recharge

	if(currPly.podMerged){
	    
	    en = clamp(en + -((global.timeFlow / room_speed) * 1), 0, enMax);
	    
	    if(en <= 0){
	        
	        switchState(currPly.state_def.run);
	        
	    }
	    
	}else if(enDelay > 0){
		enDelay += -(global.timeFlow / room_speed) * (global.hyperActive ? 4 : 1);
	}else{
		en = clamp(en + ((global.timeFlow / room_speed) * (global.hyperActive ? 4 : 1)), 0, enMax);
	}

#endregion

#region //hp regen

	var _ply = plyTeam[currPly == plyTeam[0]];
	
	_ply.hp = clamp(_ply.hp + ((0.2 * global.timeFlow) / room_speed), 0, min(_ply.hpMax, _ply.hpRegen));

#endregion

if(on_ground()){
	
	plyTeam[0].airOK = true;
	plyTeam[1].airOK = true;
	
}

var
_plyKey = -1,
_defKey = -1;

if(scr_playerIO([en_input.GAME_ATK1], en_ioType.PRESS)){
	_plyKey = 0;
}else if(scr_playerIO([en_input.GAME_ATK2], en_ioType.PRESS)){
	_plyKey = 1;
}else if(scr_playerIO([en_input.GAME_ATK_CURRENT], en_ioType.PRESS)){
    _plyKey = currPly == plyTeam[1];
}

if(scr_playerIO([en_input.GAME_DEF1], en_ioType.PRESS)){
	_defKey = 0;
}else if(scr_playerIO([en_input.GAME_DEF2], en_ioType.PRESS)){
	_defKey = 1;
}else if(scr_playerIO([en_input.GAME_DEF_CURRENT], en_ioType.PRESS)){
    _defKey = currPly == plyTeam[1];
}

if(io_check(en_ioType.RELEASE, [en_input.GAME_SWITCH])){
    switching = false;
}

if(io_check(en_ioType.PRESS, [en_input.GAME_SWITCH])){
    
    var _sChar = currPly == plyTeam[0];
    
    if(checkState(noone) && plyTeam[_sChar].hp >= 1){
        switchPly();
    }else{
        switching = true;
    }
    
}

var _newState = noone;

if(!input_lock){

	if(_plyKey != -1){
	
    	if(switching){
    	    _plyKey = !_plyKey;
    	}
    	
    	if((on_ground() || plyTeam[_plyKey].airOK) && plyTeam[_plyKey].hp >= 1){
    		
    		switchPly(plyTeam[_plyKey]);
    		
    		move_lock = true;
    		
    		if(scr_playerIO([en_input.UNI_UP])){
    			
    			_newState = currPly.state_atkUp;
    			
    		}else if(scr_playerIO([en_input.UNI_DOWN])){
    			
    			_newState = currPly.state_atkDn;
    			
    		}else{
    			
    			_newState = currPly.state_atk;
    			
    		}
		
		}
	
	}else if(_defKey != -1){
	
		if(switching){
    	    _defKey = !_defKey;
    	}
		
		if(plyTeam[_defKey].hp >= 1){
		
    		switchPly(plyTeam[_defKey]);
    		
    		move_lock = true;
    		
    		_newState = currPly.state_def;
		
		}
	
	}

}

if(_newState != noone && _newState.canRun() && _newState.enCost <= en && (checkState(noone) || _newState != lastAct)){
			
	if(io_check(en_ioType.DOWN, [en_input.UNI_LEFT])){
	    image_xscale = -1;
	}else if(io_check(en_ioType.DOWN, [en_input.UNI_RIGHT])){
	    image_xscale = 1;
	}
	
	lastAct = _newState;
	
	useEn(_newState.enCost);
	
	switchState(_newState.run);
			
	if(!on_ground() && _newState.airLimit){
		currPly.airOK = false;
	}
			
}

#region //forcePod handling

    if(checkState(noone)){
        
        forcePod.tgtX = x + -(15 * image_xscale);
        forcePod.tgtY = y + -22;
        
        forcePod.angle = -90 + (90 * image_xscale);
        
    }
    
    with forcePod{
        
        var _rate = 0.2;
        
        xx = lerp(xx, tgtX, _rate);
        yy = lerp(yy, tgtY, _rate);
        
        glow.x = xx + -0.5;
        glow.y = yy + -0.5;
        
    }

#endregion

#region //hyper

    if(scr_playerIO([en_input.GAME_HYPER]) && checkState(noone) && !global.hyperActive && global.hyper >= 1){
        hyperStart();
    }
    
    if(instance_exists(global.hyperAfterImg)){
        
        global.hyperAfterImg.x = x;
        global.hyperAfterImg.y = y;
        global.hyperAfterImg.image_xscale = image_xscale * (2 + -global.hyperAfterImg.image_alpha);
        global.hyperAfterImg.image_yscale = abs(global.hyperAfterImg.image_xscale);
        global.hyperAfterImg.sprite_index = sprite_index;
        
    }
    
    globalvar G_nim;
	G_nim = false;
    
    with obj_ui{
        
        if(uiOffset[1] == 1){
            
            G_nim = true;
            
        }
        
    }
    
    if(global.hyperActive && !G_nim){
        
        global.hyperTime += -TICK * global.timeFlow;
        
        if(global.hyperTime <= 0 && checkState(noone)){
            
            if(global.hyper >= 1){
                
                global.hyperTime = HYPER_DURATION;
                global.hyper = 0;
                global.hyperChain++;
                
                global.bonus_hyper[0] = max(global.bonus_hyper[0], global.hyperChain);
                
            }else{
            
                endHyper();
            
            }
            
        }
        
    }

#endregion

#region //camera buffer
    
    //NOTE: camera x and y behave slightly differently, lead is used for x only
    
    var
    _cb_size = 8,
    _cx = 0,
    _cy = 0,
    _csc = 0.5, //camera shake correction rate
    _p1 = 0.8, //parallax factor
    _p2 = 0.9,
    _panTgt = 0;
    
    if(
        !io_check(en_ioType.DOWN, [en_input.UNI_LEFT, en_input.UNI_RIGHT])
        && io_check(en_ioType.DOWN, [en_input.UNI_UP, en_input.UNI_DOWN])
        && checkState(noone)
        && !global.nim
        && obj_player.cam_xTgt == -1
        && obj_player.cam_yTgt == -1
    ){
    	
    	if(panTimer < 1.5){
    		panTimer += TICK;
    	}else{
    		_panTgt = io_check(en_ioType.DOWN, [en_input.UNI_DOWN]) ? 1 : -1;
    	}
    	
    }else{
    	panTimer = 0;
    }
    
    vertPan = lerp(vertPan, _panTgt * 50, 0.2);
    
    cam_shakeX = lerp(cam_shakeX, 0, _csc * global.timeFlow);
    cam_shakeY = lerp(cam_shakeY, 0, _csc * global.timeFlow);
    
    if(cam_xTgt <= 0 && cam_yTgt <= 0){
    	
    	cam_lead = lerp(cam_lead, image_xscale * _cb_size, 0.2);
    	cam_x = x;
    	_cx = cam_x + -(camera_get_view_width(view_camera[0]) / 2) + cam_lead;
    	
    	//cam_y = clamp(lerp(cam_y, y, 0.2), y + -_cb_size, y + _cb_size);
    	cam_y = lerp(cam_y, y, 0.2);
    	_cy = cam_y + -(camera_get_view_height(view_camera[0]) * 0.7);
    	
    }else{
    
    	cam_lead = lerp(cam_lead, cam_xTgt, 0.2);
    	_cx = cam_x + -(camera_get_view_width(view_camera[0]) / 2) + cam_lead;
    	
    	cam_y = lerp(cam_y, cam_yTgt, 0.2);
    	_cy = cam_y + -(camera_get_view_height(view_camera[0]) * 0.7);
    
    }
    
    _cx = clamp(_cx, 0, room_width + -camera_get_view_width(view_camera[0])) + cam_shakeX;
    _cy = clamp(_cy + vertPan, 0, room_height + -camera_get_view_height(view_camera[0])) + cam_shakeY;
    
    camera_set_view_pos(view_camera[0], _cx, _cy);
    
    var _f_layerPos = function(__ly, __x, __y, __p, __xOff, __yOff){
        
        layer_x(__ly, (__x * __p) + __xOff);
        layer_y(__ly, (__y * __p) + __yOff);
        
    }
    
    _f_layerPos("BG_pFront", _cx, _cy, 0.8, 0, 0);
    _f_layerPos("BG_pRear", _cx, _cy, 0.9, 0, 0);
    
    _f_layerPos("BG_treeFront", _cx, _cy, 0, 0, -50 * (room != rm_lv3_2));
    _f_layerPos("BG_treeRear", _cx, _cy, 0.1, 70, -60);
    
    if(instance_number(obj_ui)){
        
        obj_ui.x = _cx;
        obj_ui.y = _cy;
        
    }

#endregion

//debug keys

if(keyboard_check_pressed(vk_f1)){
	
	checkDebugView();
	
	global.debugView = !global.debugView;
	
	with objA_solid{
		visible = !visible;
	}
	
	with obj_cb_passThru{
		visible = !visible;
	}
	
	with objA_trigger{
		visible = !visible;
	}
	
}

if(global.debugView){

    if(keyboard_check_pressed(vk_home)){
    	
    	game_restart();
    	
    }
    
    if(keyboard_check_pressed(vk_pageup)){
    	
    	loseHp(-99);
    	
    }
    
    if(keyboard_check_pressed(vk_pagedown)){
    	
    	loseHp(99);
    	
    }
    
    if(keyboard_check_pressed(vk_end)){
    	
    	with obj_ui{
    	    fc_gameOver_1();
    	}
    	
    }
    
    if(keyboard_check_pressed(vk_delete)){
    	
        global.hyper = 1;
    	
    }
    
    if(keyboard_check_pressed(vk_numpad1)){
    	
    	room_goto(rm_lv1_1);
    	
    }
    
    if(keyboard_check_pressed(vk_numpad2)){
    	
    	room_goto(rm_lv2_1);
    	
    }

}

/**/

if(global.timeSlow > 0){
	
	global.timeSlow += -1 / room_speed;
	
	if(global.timeSlow <= 0){
		global.timeFlow = 1;
	}
	
}