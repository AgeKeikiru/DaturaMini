event_inherited();

intf_platforming_implement();

depth = -999;

lst_hits = ds_list_create(); //keep track of enemies hit

dmg = 0;
duration = -1;
weight = 0;
push = 3;
lift = 2;
atkStun = 0.3;

#macro SLOW_STD 0.2
slowTo = -1;
slowDur = 0.2;

passWall = true;
passEnemy = true;

//projectile velocity
pv_x = 0;
pv_y = 0;
pv_d = 0; //directional

//cam shake effects
shakeX = [-1, 1];
shakeY = [-1, 1];
shake_onDeath = false;