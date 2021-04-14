/*
upward tunnel

introduce crumble platform (implement crumble platform logic)
introduce damage tile (Actor, implement fixed position property)
introduce lily (enemy, fixed)
platforming over damage tiles
lilies + damage tiles

item, double jump required to access without taking damage
__     __
  | |_|
  |    __
  |___|
  
enemy arena with scattered damage tiles
	slime wave
	lily + flyer wave
	
crumble platforming over damage tiles with flyers and slimes (slimes only on solid platforms)
full mixed enemy group with damage tiles
*/

scr_segmentInit();

global.rmNext = rm_lv1_boss;