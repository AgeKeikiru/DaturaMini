event_inherited();

if(!hazard && object_is_ancestor(other.object_index, obj_enemy) && !other.checkState(other.fn_state_dead) && !other.player && ds_list_find_index(lst_hits, other.id) == -1){
	
	ds_list_add(lst_hits, other.id);
	
	if(ds_list_find_index(other.lst_uniqueHits, object_index) == -1){
		ds_list_add(other.lst_uniqueHits, object_index);
	}
	
	takeDmg(other, dmg * (global.hyperActive ? 2 : 1), push, lift, atkStun);
	
	addHyper(global.map_hyperValue[? object_index] * 0.02);
	
	if(other.hp <= 0){
		
		addHyper(0.05);
		
		other.switchState(other.fn_state_dead);
		
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