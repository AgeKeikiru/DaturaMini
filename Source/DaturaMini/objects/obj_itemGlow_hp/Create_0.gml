event_inherited();

image_blend = c_red;

size = 3;

contact = function(){
	
	with obj_player{
		
		currPly.hp = clamp(currPly.hp + 1, 0, currPly.hpMax);
		currPly.hpRegen = max(currPly.hpRegen, currPly.hp);
		
	}
	
}