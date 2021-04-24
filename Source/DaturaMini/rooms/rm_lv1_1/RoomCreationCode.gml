/*
flat into slope
required jump
introduce slime
passthru jump
introduce flyer
combined enemy encounter

   __
__|____ can see behind wall, but must jump over, possibly showing an item/breakable

light platforming, fight mixed enemies in groups of 2-5
*/

scr_stageInit();

with obj_ui{

	fc_next = fc_intro_1;
	audf_playBgm(bgm_stage1);

}

global.rmNext = rm_lv1_2;
global.bonus_time = [0, ((6 * 60) + 20) * room_speed];