event_inherited();

if(!hazard && !object_is_ancestor(other.object_index, objA_pAtk) && !other.player && ds_list_find_index(lst_hits, other.id) == -1){
	
	ds_list_add(lst_hits, other.id);
	
	takeDmg(other, dmg, push, lift, atkStun);
	
	if(slowTo > 0 && slowDur > 0){
		
		global.timeFlow = slowTo;
		global.timeSlow = slowDur;
		
	}
	
	if(!passEnemy){
		instance_destroy();
	}
	
	shakeCam(random_range(shakeX[0], shakeX[1]), random_range(shakeY[0], shakeY[1]));
	
}