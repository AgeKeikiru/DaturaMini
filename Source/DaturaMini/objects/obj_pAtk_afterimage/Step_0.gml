event_inherited();

if(image_alpha > 0.2){
	image_alpha += -(20 * global.timeFlow) / room_speed;
}else{
	
	image_alpha = 1;
	drawX = x;
	drawY = y;
	
}