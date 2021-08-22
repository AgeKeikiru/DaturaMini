screenLock = true;

camOff = [0, 5];
wallTag = "1wall";

arr_toSpawn = [

	[
		new lwo_triggerSpawn(obj_slime, -10, 8),
		new lwo_triggerSpawn(obj_slime, 10, 8),
		new lwo_triggerSpawn(obj_conflyer, -8, 4),
		new lwo_triggerSpawn(obj_conflyer, 5, 2),
		new lwo_triggerSpawn(obj_conflyer, 0, 7)
	],
	[
		new lwo_triggerSpawn(obj_slime, 2, 8),
		new lwo_triggerSpawn(obj_paraslime, -10, 8),
		new lwo_triggerSpawn(obj_paraslime, 10, 8),
		new lwo_triggerSpawn(obj_wndr, 0, 0)
	]/**/

];

fnA_trigger = function(){
	
	var
	_left = getTagged("1left")[0],
	_right = getTagged("1right")[0],
	_top = getTagged("1top")[0];
	
	_top.y = _left.y + -8;
	
}