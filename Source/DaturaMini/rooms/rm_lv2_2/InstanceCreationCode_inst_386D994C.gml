screenLock = true;

camOff = [0, 5];
wallTag = "7wall";

arr_toSpawn = [

	[
		new lwo_triggerSpawn(obj_slime, -8, 9),
		new lwo_triggerSpawn(obj_slime, 8, 9),
		new lwo_triggerSpawn(obj_conflyer, -10, 3),
		new lwo_triggerSpawn(obj_conflyer, 0, 0),
		new lwo_triggerSpawn(obj_conflyer, 10, 3)
	],
	[
		new lwo_triggerSpawn(obj_paraslime, -10, 9),
		new lwo_triggerSpawn(obj_paraslime, 0, 9),
		new lwo_triggerSpawn(obj_paraslime, 10, 9),
		new lwo_triggerSpawn(obj_firefly, -7, -3),
		new lwo_triggerSpawn(obj_firefly, 7, -3)
	],
	[
		new lwo_triggerSpawn(obj_conflyer, -10, 3),
		new lwo_triggerSpawn(obj_conflyer, 0, 0),
		new lwo_triggerSpawn(obj_conflyer, 10, 3),
		new lwo_triggerSpawn(obj_firefly, -10, 6),
		new lwo_triggerSpawn(obj_firefly, 10, 6),
		new lwo_triggerSpawn(obj_wndr, -5, 0),
		new lwo_triggerSpawn(obj_wndr, 5, 0)
	]/**/

];

fnA_trigger = function(){
	
	var
	_left = getTagged("7left")[0],
	_right = getTagged("7right")[0],
	_top = getTagged("7top")[0];
	
	_right.image_yscale = 10;
	_left.image_yscale = _right.image_yscale;
	_left.y = _right.y;
	_top.y = _right.y + -8;
	
}