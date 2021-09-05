screenLock = true;

camOff = [0, 5];
wallTag = "2wall";

arr_toSpawn = [

	[
		new lwo_triggerSpawn(obj_swordman, 6, 7),
		new lwo_triggerSpawn(obj_lily, -13, 10),
		new lwo_triggerSpawn(obj_lily, 13, 9),
		new lwo_triggerSpawn(obj_firefly, 10, 2),
		new lwo_triggerSpawn(obj_firefly, -10, 2)
	],
	[
		new lwo_triggerSpawn(obj_slime, -4, 6),
		new lwo_triggerSpawn(obj_slime, 5, 7),
		new lwo_triggerSpawn(obj_paraslime, -8, 7),
		new lwo_triggerSpawn(obj_paraslime, 10, 7),
		new lwo_triggerSpawn(obj_wndr, 0, 0),
		new lwo_triggerSpawn(obj_conflyer, 9, 2),
		new lwo_triggerSpawn(obj_conflyer, -9, 2),
		new lwo_triggerSpawn(obj_firefly, 13, 4),
		new lwo_triggerSpawn(obj_firefly, -13, 4)
	],
	[
		new lwo_triggerSpawn(obj_swordman, 10, 7),
		new lwo_triggerSpawn(obj_swordman, -10, 9),
		new lwo_triggerSpawn(obj_wndr, -5, 0),
		new lwo_triggerSpawn(obj_wndr, 5, 0),
		new lwo_triggerSpawn(obj_conflyer, 0, 2),
		new lwo_triggerSpawn(obj_conflyer, -10, 6),
		new lwo_triggerSpawn(obj_conflyer, 10, 6)
	]/**/

];

fnA_trigger = function(){
	
	var
	_left = getTagged("2left")[0],
	_right = getTagged("2right")[0];
	
	_left.image_yscale = _right.image_yscale;
	_left.y = _right.y;
	
}