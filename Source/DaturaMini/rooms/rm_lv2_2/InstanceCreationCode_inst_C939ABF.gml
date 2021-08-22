screenLock = true;

camOff = [0, 5];
wallTag = "3wall";

arr_toSpawn = [

	[
		new lwo_triggerSpawn(obj_slime, -10, 8),
		new lwo_triggerSpawn(obj_slime, 10, 8),
		new lwo_triggerSpawn(obj_conflyer, -9, 1),
		new lwo_triggerSpawn(obj_conflyer, -5, -6),
		new lwo_triggerSpawn(obj_conflyer, 5, -6),
		new lwo_triggerSpawn(obj_conflyer, 9, 1)
	],
	[
		new lwo_triggerSpawn(obj_slime, -12, 8),
		new lwo_triggerSpawn(obj_slime, -10, 4),
		new lwo_triggerSpawn(obj_slime, -6, 8),
		new lwo_triggerSpawn(obj_firefly, 5, -6),
		new lwo_triggerSpawn(obj_firefly, 10, 1),
		new lwo_triggerSpawn(obj_wndr, 0, 0)
	],
	[
		new lwo_triggerSpawn(obj_slime, -7, -4),
		new lwo_triggerSpawn(obj_slime, 0, -4),
		new lwo_triggerSpawn(obj_slime, 7, -4),
		new lwo_triggerSpawn(obj_paraslime, 0, 8),
		new lwo_triggerSpawn(obj_conflyer, -10, 2),
		new lwo_triggerSpawn(obj_conflyer, 10, 2),
		new lwo_triggerSpawn(obj_firefly, -12, -6),
		new lwo_triggerSpawn(obj_firefly, 12, -6)
	],
	[
		new lwo_triggerSpawn(obj_wndr, 0, 0),
		new lwo_triggerSpawn(obj_paraslime, -10, 4),
		new lwo_triggerSpawn(obj_paraslime, 10, 4),
		new lwo_triggerSpawn(obj_wndr, -5, 0),
		new lwo_triggerSpawn(obj_firefly, 0, 0),
		new lwo_triggerSpawn(obj_firefly, 0, 8),
		new lwo_triggerSpawn(obj_wndr, 5, 0)
	]/**/

];

fnA_trigger = function(){
	
	var
	_left = getTagged("3left")[0],
	_right = getTagged("3right")[0];
	
	_left.image_yscale = _right.image_yscale;
	_left.y = _right.y;
	
}