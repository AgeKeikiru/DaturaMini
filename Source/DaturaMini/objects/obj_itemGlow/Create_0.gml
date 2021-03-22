event_inherited();

x += random_range(-8, 8);
y += random_range(-8, 8);

delay = random_range(0.2, 0.5);
size = 1;

spd = random_range(-2, 2) * 60;
direction = random(360);

lockOn = noone;

contact = function(){ /*abstract*/ }