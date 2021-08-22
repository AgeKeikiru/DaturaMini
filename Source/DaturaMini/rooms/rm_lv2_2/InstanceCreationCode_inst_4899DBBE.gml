screenLock = true;

camOff = [0, 5];
wallTag = "2wall";

arr_toSpawn = [

	[
		new lwo_triggerSpawn(obj_conflyer, -10, 7),
		new lwo_triggerSpawn(obj_conflyer, 10, 7),
		new lwo_triggerSpawn(obj_paraslime, 2, 8),
		new lwo_triggerSpawn(obj_slime, -2, 4),
		new lwo_triggerSpawn(obj_firefly, 6, -2)
	],
	[
		new lwo_triggerSpawn(obj_paraslime, -11, -2),
		new lwo_triggerSpawn(obj_paraslime, 11, -2),
		new lwo_triggerSpawn(obj_conflyer, -4, -4),
		new lwo_triggerSpawn(obj_conflyer, 4, -4),
		new lwo_triggerSpawn(obj_conflyer, -8, 6),
		new lwo_triggerSpawn(obj_conflyer, 8, 6)
	],
	[
		new lwo_triggerSpawn(obj_paraslime, 0, 4),
		new lwo_triggerSpawn(obj_slime, -10, 8),
		new lwo_triggerSpawn(obj_slime, 10, 8),
		new lwo_triggerSpawn(obj_wndr, -5, 0),
		new lwo_triggerSpawn(obj_wndr, 5, 0)
	]/**/

];

fnA_trigger = function(){
	
	var
	_left = getTagged("2left")[0],
	_right = getTagged("2right")[0],
	_top = getTagged("2top")[0];
	
	_top.y = _left.y + -8;
	
}