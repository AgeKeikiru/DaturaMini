/*
slope into jump over spikes with flyer x3
2nd jump over spikes with flyer x3
slope with slime x2, flyer x2, firefy x1
	firefly: red flyer
		tries to fly into player
		[EXH] shoot perpendicular shots while tackling
steep slope into floating solid platform section over spikes, introduce paraslime
	paraslime: does boss jump attack
		shoots short range perpendicular elec bolts on landing
		[EXH] longer distance bolts
	narrow passage under, bonus token at the end, spawns flyer x3, slime x1
arena
	flyer x3
	flyer x4, firefly x1
	firefly x3
*/

scr_stageInit();

global.txt_stageNum = "2";
global.txt_stageName = "VR\nZONE II";

with obj_ui{

	fc_next = fc_intro_1;
	audf_playBgm(bgm_stage1);

}

global.rmNext = rm_lv2_2;
global.bonus_time = [0, ((6 * 60) + 40) * room_speed];