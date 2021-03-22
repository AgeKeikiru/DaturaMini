event_inherited();

value *= 1 + (ds_list_size(lst_uniqueHits) * 0.25);

while(value > 0){
	
	var _score = scr_place(obj_itemGlow_score, x, y);
	
	if(value >= 50){
		
		_score.size = 2;
		_score.value = 50;
		
	}
	
	if(value >= 200){
		
		_score.size = 3;
		_score.value = 200;
		
	}
	
	value += -_score.value;
	
}

repeat(10){
	scr_place(obj_itemGlow_en, x, y);
}

scr_place(obj_itemGlow_hp, x, y);