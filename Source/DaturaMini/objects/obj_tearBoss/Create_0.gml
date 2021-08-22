event_inherited();

intf_boss_implement(80);

if(TESTING_MODE){
    //hp = 5;
}

cstate_time = -99999;

s_idle = sprite_index;
s_move = sprite_index;
mask_index = s_idle;

weight = 0;

moveSpd = 3;

forcePod = {
    
    xx: x + 15,
    yy: y + -15,
    angle: 180,
    
    phase: [0, 0], //0:red, 1:blue, 2:yellow
    phaseCols: [c_red, c_blue, c_yellow],
    
    vis: true
    
};

atkPhase = -1;
mergeGlow = 0;
stunLoop = 0;

forceGlow = scr_place(obj_glow, forcePod.xx, forcePod.yy);
forceGlow.image_blend = c_red;
forceGlow.depth = depth + 10;
forceGlow.trailMax = 80;

tgtSelf = [x, y];
tgtForce = [forcePod.xx, forcePod.yy];

cellGap = [14 * 8, 5 * 8];

screenMid = [room_width / 2, (room_height / 2) + 16];

fn_setPos = function(_arrCopy, _x, _y){
    
    var _arr = [0, 0];
    array_copy(_arr, 0, _arrCopy, 0, 2);
    
    if(is_undefined(_x) || is_undefined(_y)){
        
        var
		_pos = [0, 0];
		
		array_copy(_pos, 0, _arr, 0, 2);
		
		while(array_equals(_pos, _arr)){
            
            _arr = [
                
                screenMid[0] + (choose(-1, 0, 1) * cellGap[0]),
                screenMid[1] + (choose(-1, 0, 1) * cellGap[1])
                
            ];
		    
		}
        
    }else{
        
        _arr = [
                
            screenMid[0] + (_x * cellGap[0]),
            screenMid[1] + (_y * cellGap[1])
            
        ];
        
    }
    
    return _arr;
    
}

fn_bullet = function(_obj, _x, _y, _dir){
    
    var _r = scr_place(_obj, _x, _y);
    
    _r.sprite_index = spr_tracerAtk;
    _r.pv_d = 6;
    _r.direction = _dir;
    _r.image_angle = _dir;
    
    _r.glow = scr_place(obj_glow, _x, _y);
    _r.glow.size = 2;
    _r.glow.image_blend = _r.image_blend;
    _r.glow.trailMax = 60;
    _r.glow.depth = _r.depth + 10;
    
    return _r;
    
}

fn_state_move = function(){
    
    //on-enter actions
	if(cstate_new){
		
		cstate_new = false;	
		
		sprite_index = spr_tear_idle;
        
        switch(atkPhase){
            
            case 0:
                tgtSelf = fn_setPos(tgtSelf, choose(-1, 1), irandom_range(-1, 1));
                
                break;
                
            case 2:
                tgtSelf = fn_setPos(tgtSelf, 0, 0);
                
                break;
                
            default: //same as case 1
                tgtSelf = fn_setPos(tgtSelf);
                
                break;
            
        }
		
		if(tgtSelf[0] < screenMid[0]){
		    image_xscale = 1;
		}else if(tgtSelf[0] > screenMid[0]){
		    image_xscale = -1;
		}
		
		forcePod.phase[1] = (forcePod.phase[1] + choose(1, 2)) mod 3;
		
		if((hp / bossHp) < 0.5){
		    atkPhase = (atkPhase + choose(1, 2)) mod 3;
		}
				
	}
	
	forceGlow.image_blend = forcePod.phaseCols[forcePod.phase[sin(current_time / 10) > 0]];
	
	if(cstate_time > 0.8){
	
		forcePod.phase[0] = forcePod.phase[1];
		forceGlow.image_blend = forcePod.phaseCols[forcePod.phase[0]];
		
		switchState(fn_state_atk_1);
	
	}
    
}

fn_state_atk_1 = function(){
	
	var
	_phase = forcePod.phase[0],
	_blueSpread = 15;
	
	//on-enter actions
	if(cstate_new){
		
		cstate_new = false;	
		
		atkLoop = 0;
		
		switch(_phase){
		    
		    case 0:
		        tgtForce = fn_setPos(tgtForce, irandom_range(-1, 1), -1);
		        tgtForce[0] += -26;
		        tgtForce[1] += -20;
		        
		        forcePod.angle = 270;
		        
		        arr_warns[0] = new lwo_warningBeam(tgtForce[0], tgtForce[1], forcePod.angle);
		        
		        break;
		        
            case 1:
		        tgtForce = fn_setPos(tgtForce, choose(-0.2, 0.2), irandom_range(-1, 1));
		        tgtForce[1] += -8;
		        
		        forcePod.angle = (tgtForce[0] > screenMid[0]) ? 180 : 0;
		        
		        arr_warns = [
		            new lwo_warningBeam(tgtForce[0], tgtForce[1], forcePod.angle + _blueSpread),
		            new lwo_warningBeam(tgtForce[0], tgtForce[1], forcePod.angle + -_blueSpread)
		        ];
		        
		        break;
		        
	        case 2:
		        tgtForce = fn_setPos(tgtForce, choose(-1.2, 1.2), choose(-1, 1));
		        tgtForce[1] += -8;
		        
		        forcePod.angle = (tgtForce[0] > screenMid[0]) ? 180 : 0;
		        
		        arr_warns = [
		            new lwo_warningBeam(tgtForce[0], tgtForce[1], forcePod.angle)
		        ];
		        
		        break;
		    
		}
		
		switch(atkPhase){
		    
		    case 0:
		        sprite_index = spr_tear_atk;
		        
		        array_push(arr_warns, new lwo_warningBeam(x, y + -8, -90 + (90 * image_xscale)));
		        
		        break;
		        
            case 1:
		        sprite_index = spr_tear_atkUp;
		        direction = 0;
		        
		        var _w = new lwo_warningBeam(x, y + -8, 60);
		        _w.type = 1;
		        
		        array_push(arr_warns, _w);
		        
		        break;
		        
	        case 2:
		        sprite_index = spr_tear_atkUp;
		        direction = 45;
		        
		        repeat(4){
		            
		            array_push(arr_warns, new lwo_warningBeam(x, y + -8, direction));
		            
		            direction += 90;
		            
		        }
		        
		        direction = 0;
		        
		        break;
		    
		}
				
	}
	
	if(cstate_time > 0.8){
	
    	switch(_phase){
    	
    	    case 0:
            	if(atkLoop < 9){
            		    
        		    arr_warns = [];
        		    
        		    atkLoop++;
        		    
        		    cstate_time = 0.7;
        		    
        		    fn_bullet(obj_eAtk_fireball, forcePod.xx + -4, forcePod.yy + 8, forcePod.angle);
        		    fn_bullet(obj_eAtk_fireball, forcePod.xx + 4, forcePod.yy + 8, forcePod.angle);
        		    
        		    forcePod.yy += -2;
            	
            	}
            	
            	break;
            	
            case 1:
            	if(atkLoop < 9){
            		    
        		    var _facing = (forcePod.angle > 90) ? 1 : -1;
        		    
        		    arr_warns = [];
        		    
        		    atkLoop++;
        		    
        		    cstate_time = 0.7;
        		    
        		    fn_bullet(obj_eAtk_fireball, forcePod.xx + -(_facing * 8), forcePod.yy, forcePod.angle + _blueSpread);
        		    fn_bullet(obj_eAtk_fireball, forcePod.xx + -(_facing * 8), forcePod.yy, forcePod.angle + -_blueSpread);
        		    
        		    forcePod.xx += _facing * 2;
        		    
        		}
            	
            	break;
            	
            case 2:
            	if(atkLoop < 4){
            		    
        		    var _facing = (forcePod.angle > 90) ? 1 : -1;
        		    
        		    arr_warns = [];
        		    
        		    atkLoop++;
        		    
        		    cstate_time = 0.1;
        		    
        		    var _o = fn_bullet(obj_pAtk_tearDn_force, forcePod.xx + -(_facing * 8), forcePod.yy, forcePod.angle);
        		    _o.hazard = true;
        		    _o.image_blend = CC_ENEMY_PINK;
        		    _o.glow.image_blend = _o.image_blend;
        		    
        		    forcePod.xx += _facing * 2;
        		    
        		}
            	
            	break;
    	
    	}
	
	}else if(atkLoop > 0 && _phase == 0){
	    tgtForce[0] += 1 * global.timeFlow;
	}
	
	if(atkLoop > 0 && cstate_time < 0.8){
	    
	    switch(atkPhase){
	        
            case 0:
                var _o = scr_place(obj_eAtk_fireball, x + (8 * image_xscale), y + -8 + random_range(-8, 8));
                _o.image_xscale = image_xscale;
                _o.pv_x = image_xscale * 6;
                _o.sprite_index = spr_ari_atkF;
                
                s_shake = 0.5;
                
                break;
                
            case 1:
                repeat(2){
                    
                    var
                    _o = scr_place(obj_eAtk_fireball, x, y + -8);
                    _o.x += lengthdir_x(10, direction);
                    _o.y += lengthdir_y(10, direction);
                    _o.image_angle = direction;
                    _o.direction = direction;
                    _o.pv_d = 2;
                    _o.sprite_index = spr_ari_atkF;
                    _o.duration = room_speed * 0.4;
                    
                    direction += 180;
                    
                }
                
                direction += 10;
                
                break;
                
            case 2:
                if(instance_number(obj_eAtk_tracer) < 2){
                    
                    direction = 45;
                    
                    repeat(4){
                        
                        _o = scr_place(obj_eAtk_tracer, x, y + -8);
                        _o.direction = direction;
                        _o.pv_d = 1.5;
                        _o.trackSpd = 2;
                        
                        direction += 90;
                        
                    }
                    
                    direction = 0;
                    
                }
                
                break;
	        
	    }
	    
	}
	
	if(cstate_time > 3){
	    switchState(fn_state_move);
	}
	
}

fn_state_stun1 = function(){
    
    //on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		stunLoop = 0;
		
		iFrames = 99;
		
		arr_warns = [];
		
		direction = 0;
		
	}
	
	if(cstate_time > 0.5){
	    
	    sprite_index = spr_tear_def;
	    
	    array_copy(tgtForce, 0, tgtSelf, 0, 2);
	    
	    tgtForce[1] += -8;
	    
	    forcePod.angle = -90 + (90 * image_xscale);
	    
	}
	
	if(cstate_time > 1.5){
	    
	    if(forcePod.vis){
	        mergeGlow = 100;
	    }
	    
	    forcePod.vis = false;
	    forceGlow.visible = false;
	    
	    sprite_index = spr_tear_idle_FV;
	    
	}
	
	if(cstate_time > 2){
	    switchState(fn_state_stun2);
	}
    
}

fn_state_stun2 = function(){
    
    //on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		hazard = false;
		
		iFrames = 99;
		
		sprite_index = spr_tear_idle_FV;
		
		tgtSelf = fn_setPos(tgtSelf);
		
		repeat(4){
		    
		    array_push(arr_warns, new lwo_warningBeam(tgtSelf[0], tgtSelf[1] + -8, direction));
		    direction += 90;
		    
		}
		
		direction = 0;
		
	}
	
	if(cstate_time > 0.5){
	    switchState(fn_state_stun3);
	}
    
}

fn_state_stun3 = function(){
    
    //on-enter actions
	if(cstate_new){
		
		cstate_new = false;
		hazard = false;
		
		iFrames = 99;
		
		stunLoop++;
		
		//tgtSelf = fn_setPos(tgtSelf);
		
		sprite_index = spr_tear_atkUp_FV;
		
		arr_warns = [];
		
	}
	
	repeat(4){
	    
	    var _o = fn_bullet(obj_eAtk_fireball, x + random_range(-5, 5), y + -8 + random_range(-5, 5), direction);
	    _o.image_angle = direction;
	    _o.sprite_index = spr_ari_atkF;
	    _o.pv_d = 8;
	    
	    direction += 90;
	    
	}
	
	direction = 0;
	
	if(cstate_time > 0.2){
	    
	    if(stunLoop > 4){
	        
	        iFrames = 0;
	        
	        sprite_index = spr_tear_idle;
	        
	        forcePod.vis = true;
	        forceGlow.visible = true;
	        
	        array_copy(tgtForce, 0, tgtSelf, 0, 2);
	        forcePod.xx = tgtForce[0];
	        forcePod.yy = tgtForce[1];
	        tgtForce[0] += -15 * image_xscale;
	        tgtForce[1] += -15;
	        
	        switchState(noone);
	        
	    }else{
	        switchState(fn_state_stun2);
	    }
	    
	}
    
}