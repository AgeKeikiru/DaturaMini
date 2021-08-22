screenLock = true;

camOff = [0, 5];
wallTag = "8wall";

arr_toSpawn = [

	[
		new lwo_triggerSpawn(obj_wndr, 0, 0)
	],
	[
		new lwo_triggerSpawn(obj_paraslime, 0, 9),
		new lwo_triggerSpawn(obj_conflyer, -8, 0),
		new lwo_triggerSpawn(obj_conflyer, 0, -2),
		new lwo_triggerSpawn(obj_conflyer, 8, 0)
	],
	[
		new lwo_triggerSpawn(obj_firefly, -6, 3),
		new lwo_triggerSpawn(obj_conflyer, -10, 8),
		new lwo_triggerSpawn(obj_firefly, 6, 3),
		new lwo_triggerSpawn(obj_conflyer, 10, 8),
		new lwo_triggerSpawn(obj_wndr, 0, 0)
	]/**/

];

fnA_trigger = function(){
	
	var
	_left = getTagged("8left")[0],
	_right = getTagged("8right")[0],
	_top = getTagged("8top")[0];
	
	_right.image_yscale = _left.image_yscale;
	_right.y = _left.y;
	_top.y = _left.y + -8;
	
}