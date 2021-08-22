screenLock = true;

camOff = [0, 5];
wallTag = "4wall";

arr_toSpawn = [

	[
		new lwo_triggerSpawn(obj_slime, -8, 2),
		new lwo_triggerSpawn(obj_slime, 8, 2),
		new lwo_triggerSpawn(obj_conflyer, -12, 0)
	],
	[
		new lwo_triggerSpawn(obj_slime, -10, 2),
		new lwo_triggerSpawn(obj_slime, 10, 2),
		new lwo_triggerSpawn(obj_slime, 5, 2),
		new lwo_triggerSpawn(obj_firefly, -12, 0),
		new lwo_triggerSpawn(obj_firefly, 12, 0)
	]/**/

];

fnA_trigger = function(){
	
	var
	_left = getTagged("4left")[0],
	_right = getTagged("4right")[0];
	
	_right.image_yscale = _left.image_yscale;
	_right.y = _left.y;
	
}