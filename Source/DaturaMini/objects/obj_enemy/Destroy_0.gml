event_inherited();

audf_playSfx(sfx_death);

if(!noCount){
    global.bonus_kill[0] += 1;
}

value *= 1 + (ds_list_size(lst_uniqueHits) * 0.25) + (global.hyperChain * 0.5);

while(value > 0){
	
	var _score = scr_place(obj_itemGlow_score, x, y);
	
	if(value >= 100){
		
		_score.size = 2;
		_score.value = 50;
		
	}
	
	if(value >= 500){
		
		_score.size = 3;
		_score.value = 200;
		
	}
	
	value += -_score.value;
	
}

if(!boss){

    repeat(10){
    	scr_place(obj_itemGlow_en, x, y);
    }
    
    var
    _rate = 0;
    
    if(instance_exists(obj_player)){
    	_rate = clamp(obj_player.currPly.hpRegen + -obj_player.currPly.hp, 0, 2) * 0.05;
    }
    
    if(random(1) < _rate){
    	scr_place(obj_itemGlow_hp, x, y);
    }

}