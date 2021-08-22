event_inherited();

duration = room_speed * 5;
dmg = 1;
//push = 2;
//lift = 0;
//atkStun = 0;

passWall = false;
passEnemy = false;

lockOn = noone;
explosive = true;
trackSpd = 4;

moveSpd = 3.5;
pv_d = moveSpd;

slowTo = SLOW_STD;

glow = scr_place(obj_glow, x, y);
glow.size = 1;
glow.image_blend = c_red;
glow.depth = depth + 10;
glow.trailMax = 60;