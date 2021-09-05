screenLock = true;

camOff = [0, 5];
wallTag = "1wall";

arr_toSpawn = [

	[
		new lwo_triggerSpawn(obj_lily, -13, 8),
		new lwo_triggerSpawn(obj_lily, 13, 9),
		new lwo_triggerSpawn(obj_lily, 0, 3),
		new lwo_triggerSpawn(obj_wndr, -5, 0),
		new lwo_triggerSpawn(obj_wndr, 5, 0),
		new lwo_triggerSpawn(obj_firefly, 6, 0),
		new lwo_triggerSpawn(obj_firefly, -6, 6)
	],
	[
		new lwo_triggerSpawn(obj_slime, 6, 2),
		new lwo_triggerSpawn(obj_slime, -6, 2),
		new lwo_triggerSpawn(obj_paraslime, 4, 8),
		new lwo_triggerSpawn(obj_paraslime, -4, 7),
		new lwo_triggerSpawn(obj_conflyer, -3, -2),
		new lwo_triggerSpawn(obj_conflyer, -10, 6),
		new lwo_triggerSpawn(obj_conflyer, 10, 2)
	],
	[
		new lwo_triggerSpawn(obj_swordman, -3, 10)
	]/**/

];

fnA_trigger = function(){
	
	var
	_left = getTagged("1left")[0],
	_right = getTagged("1right")[0];
	
	_left.image_yscale = _right.image_yscale;
	_left.y = _right.y;
	
}