// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_segmentInit(){

	var _scale = 0.5;

	layer_background_xscale(layer_background_get_id("BG_pRear"), _scale);
	layer_background_yscale(layer_background_get_id("BG_pRear"), _scale);

	with obj_ui{

		fc_next = fc_segment_fadeIn_1;
	    fc_delay = 0.3;

	}

}