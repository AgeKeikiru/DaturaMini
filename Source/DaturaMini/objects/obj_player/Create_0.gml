event_inherited();

input_lock = true;

lastAct = noone;

switching = false;

panTimer = 0;
vertPan = 0;

function switchPly(_ply){

	if(is_undefined(_ply)){
	    
	    _ply = plyTeam[currPly == plyTeam[0]];
	    
	}
	
	if(_ply != currPly){
	
		if(variable_struct_exists(currPly, "fn_forceSplit")){
		
		    with currPly{
		    
                fn_forceSplit();
		    
		    }
		    
		}
		
		currPly = _ply;
		currPly.hp  = floor(currPly.hp);
		
		s_idle = currPly.s_idle;
		s_move = currPly.s_move;
		sprite_index = s_idle;
	
	}

}

function useEn(_amt){

	en = clamp(en + -_amt, 0, enMax);
	
	if(_amt > 0){
	    
		enDelay = 1.5;
		
		with obj_ui{
		    uiMini = 1.5;
		}
		
	}

}

function loseHp(_amt, _ply){

	_amt = is_undefined(_amt) ? 1 : _amt;
	_ply = is_undefined(_ply) ? currPly : _ply;
	
	if(global.hyperActive){
	    endHyper();
	}
	
	addHyper(-0.2);
	
	_ply.hp = clamp(_ply.hp + -_amt, 0, _ply.hpMax);
	
	if(_ply.hp <= 0){
	    
		_ply.hp = -1; //set to -1 to ensure regen is set to the proper value
		
		switchPly();
		
		var _p2 = scr_place(obj_deadPlayer, x, y);
		
		_p2.sprite_index = _ply.s_idle;
		
	}
	
	_ply.hpRegen = clamp(_ply.hpRegen, _ply.hp, _ply.hp + 2);
	
	with obj_ui{
	    uiMini = 1.5;
	}
	
	if(plyTeam[0].hp <= 0 && plyTeam[1].hp <= 0){
	    
	    with obj_ui{
	        
	        uiMini = 0;
	        fc_gameOver_1();
	        
	    }
	    
	}

}

function hyperStart(){
    
    global.hyperActive = true;
    global.hyperTime = HYPER_DURATION;
    global.hyper = 0;
    global.hyperChain = 1;
    
    global.hyperAfterImg = scr_place(obj_pAtk_afterimage, x, y);
    global.hyperAfterImg.src = id;
	global.hyperAfterImg.depth = depth + 99;
	global.hyperAfterImg.image_blend = c_fuchsia;
	global.hyperAfterImg.sprite_index = sprite_index;
	global.hyperAfterImg.mask_index = spr_noMask;
	global.hyperAfterImg.dmg = 0;
	global.hyperAfterImg.atkStun = 0;
	global.hyperAfterImg.slowTo = 1;
	global.hyperAfterImg.slowDur = 0;
	
	if(currPly.podMerged){
	    
	    with currPly{
	        fn_forceSplit();
	    }
	    
	}
	
	audf_playSfx(sfx_buff);
	audf_playSfx(sfx_whish1);
    
}

function forceScanTri(){
    
    var _r = [
        
        [x, y + -10],
        [x, y + -10],
        [x, y + -10]
        
    ];
    
    _r[1][0] += lengthdir_x(forcePod.scanDist, direction + -45);
    _r[1][1] += lengthdir_y(forcePod.scanDist, direction + -45);
    
    _r[2][0] += lengthdir_x(forcePod.scanDist, direction + 45);
    _r[2][1] += lengthdir_y(forcePod.scanDist, direction + 45);
    
    return _r;
    
}

var _roster = [
    
    new plyData_imo(id),
    new plyData_ari(id),
    new plyData_bre(id),
    new plyData_tear(id),
    new plyData_ari(id),
    new plyData_ari(id)
    
];

plyTeam = [_roster[global.arr_team[0]], _roster[global.arr_team[1]]];
plyTeam[0].slot2 = false;
plyTeam[1].slot2 = true;

player = true;

en = 6;
enMax = en;
enDelay = 0;

currPly = noone;
switchPly(plyTeam[0]);
mask_index = spr_imo_idle;

cam_x = x;
cam_y = y;
cam_xTgt = -1;
cam_yTgt = -1;
cam_lead = 1;
cam_leadTgt = cam_lead;
cam_shakeX = 0;
cam_shakeY = 0;

forcePod = {
    
    xx: 0,
    yy: 0,
    tgtX: 0,
    tgtX: 0,
    
    angle: 0,
    scanDist: 100,
    
    vis: true,
    
    lockon: noone,
    
    glow: scr_place(obj_glow, 0, 0)
    
}

with forcePod.glow{
    
    visible = false;
    image_blend = c_lime;
    
}