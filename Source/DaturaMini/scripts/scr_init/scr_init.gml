function scr_init(){
	
	surface_resize( application_surface, camera_get_view_width( view_camera[0] ), camera_get_view_height( view_camera[0] ) );
	
	scr_place(obj_ui);
	
}

global.timeFlow = 1;
global.timeSlow = 0;
global.timeDebug = false;

global.points = 0;