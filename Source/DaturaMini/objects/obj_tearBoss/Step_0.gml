event_inherited();

var _spd = 0.1;

x = lerp(x, tgtSelf[0], _spd);
y = lerp(y, tgtSelf[1], _spd);

forcePod.xx = lerp(forcePod.xx, tgtForce[0], _spd);
forcePod.yy = lerp(forcePod.yy, tgtForce[1], _spd);

if(checkState(noone) && cstate_time > 1.5){

	switchState(fn_state_move);

}