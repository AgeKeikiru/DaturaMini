event_inherited();

if(fn_collCheck(other)){
	
	var _dmg = dmg;
	
	if(other.sp_frozen && other.stun > 0 && !sp_freeze){
	    
	    _dmg *= 1.5;
	    //get unique shatter sound effect
	    audf_playSfx(sfx_buff);
	    other.stun = 0;
	    
	}
	
	other.sp_frozen = sp_freeze;
	
	if(sp_freeze){
	    //get unique freeze sound effect
	    audf_playSfx(sfx_cut2);
	}
	
	audf_playSfx(hitSound);
	
	ds_list_add(lst_hits, other.id);
	
	if(ds_list_find_index(other.lst_uniqueHits, object_index) == -1){
		ds_list_add(other.lst_uniqueHits, object_index);
	}
	
	takeDmg(other, _dmg * (global.hyperActive ? 2 : 1), push, lift, atkStun);
	
	fn_addSpark(clamp(x, other.bbox_left, other.bbox_right), clamp(y, other.bbox_top, other.bbox_bottom));
	
	addHyper(global.map_hyperValue[? object_index] * 0.02);
	
	if(other.hp <= 0){
		
		addHyper(0.05);
		
		other.switchState(other.boss ? other.fn_state_bossDead : other.fn_state_dead);
		
	}else if(other.boss){
	    other.bossStun += _dmg;
	}
	
	if(slowTo > 0 && slowDur > 0){
		
		global.timeFlow = slowTo;
		global.timeSlow = slowDur;
		
	}
	
	if(!passEnemy){
		instance_destroy();
	}
	
	shakeCam(random_range(shakeX[0], shakeX[1]), random_range(shakeY[0], shakeY[1]));
	
}