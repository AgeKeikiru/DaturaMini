screenLock = true;

camOff = [0, 5];
wallTag = "wall";

arr_toSpawn = [

	[
		new lwo_triggerSpawn(obj_conflyer, 6, 0),
		new lwo_triggerSpawn(obj_conflyer, 10, 4),
		new lwo_triggerSpawn(obj_conflyer, 8, -2)
	],
	[
		new lwo_triggerSpawn(obj_conflyer, -10, 4),
		new lwo_triggerSpawn(obj_conflyer, -5, 2),
		new lwo_triggerSpawn(obj_conflyer, 5, 2),
		new lwo_triggerSpawn(obj_conflyer, 10, 4),
		new lwo_triggerSpawn(obj_firefly, 0, 0)
	],
	[
		new lwo_triggerSpawn(obj_firefly, -10, 6),
		new lwo_triggerSpawn(obj_firefly, 10, 6),
		new lwo_triggerSpawn(obj_firefly, 0, -2)
	]

];

fnA_trigger = function(){
	
	var
	_left = getTagged("left")[0],
	_right = getTagged("right")[0];
	
	_left.image_yscale = _right.image_yscale;
	_left.y = _right.y;
	
}