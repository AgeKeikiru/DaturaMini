function scr_init(){
	
	randomize();
	
	surface_resize( application_surface, camera_get_view_width( view_camera[0] ), camera_get_view_height( view_camera[0] ) );
	
	scr_place(obj_ui);
	
}

global.nim = false;

global.timeFlow = 1;
global.timeSlow = 0;
global.timeDebug = false;

global.points = 0;

global.hyperActive = false;
global.hyperAfterImg = noone;
global.hyperTime = 0;
global.hyperChain = 0;
global.hyper = 0;

global.map_hyperValue = ds_map_create();

global.rmNext = rm_test;

global.bonus_time = 0;
global.bonus_kills = 0;
global.bonus_token = 0;
global.bonus_hyper = 3;

#macro HYPER_DURATION 8
#macro CC_HYPINK $feaeff