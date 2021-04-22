fn_trigger = function(){
	
	with obj_ui{
	
		fc_segment_fadeOut_1();
		
		audio_sound_gain(bgmCurr, 0, 500);
	
	}
	
	instance_destroy();
	
}

/*/testing
obj_player.x = x + -16;
obj_player.y = y;
audf_playBgm(bgm_stage1);