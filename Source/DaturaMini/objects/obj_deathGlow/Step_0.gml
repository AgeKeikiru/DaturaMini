event_inherited();

x += (spdX * global.timeFlow) / room_speed;
y += (spdY * global.timeFlow) / room_speed;

spdY += (global.timeFlow * 25 * 60) / room_speed;

duration += -global.timeFlow / room_speed;

if(duration <= 0){
	live = false;
}