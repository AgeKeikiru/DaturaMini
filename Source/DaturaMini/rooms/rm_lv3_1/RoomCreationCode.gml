/*
slope into flat with paraslime x2
flat into flyer x5, lily
slopes with lily x3, flyer x3, firefly x2
arena
	lily on edges (not part of wave)
	wanderer, flyer x2
	slime x2, firefly x3
slopes with waves of flyers, fireflies, and lilies
arena
	lily on edges (not part of wave)
	wanderer x2, firefly x2
	paraslime x2, slime x2, flyer x3
	swordman
slopes with waves of fireflies, slimes, and paraslimes
arena
	wanderer x2, paraslime x2, slime x3
	swordman x2
jump into ravine
*/

scr_stageInit();

layer_background_xscale(layer_get_id("BG_treeRear"), 0.5);

global.txt_stageNum = "3";
global.txt_stageName = "JUNGLE\nEXPLODER";

with obj_ui{

	fc_next = fc_intro_1;
	audf_playBgm(bgm_stage1);

}

global.rmNext = rm_lv3_2;
global.bonus_time = [0, ((6 * 60) + 40) * room_speed];