/*
room arrangement
789
456
123

room switch order
569824713

arenas
	8
		wanderer x1
			wanderer: circles the player
				intangible to terrain
				at regular intervals changes distance from the player
				every 4th interval pauses to fire a slowly sweeping stream of bullets at the player
				[EXH] fires 2 streams in a cone formation
		paraslime, flyer x3
		flyer x2, firefly x2, wanderer x1
	2
		firefly x1, paraslime x1, slime x1, flyer x2
		paraslime x2, flyer x4
		wanderer x2, paraslime x1, slime x2
	4
		slime x2, flyer x1
		slime x3, firefly x2
	7
		fire dumpers
			fire dumper: expell bullets downwards on loop when in trigger zone
				not an enemy
		slime x3, flyer x2
		paraslime x2, firefly x3
		wanderer x2, firefly x2, flyer x3
	1
		flyer x3, slime x2
		wanderer x1, paraslime x2, slime x1
	3
		slime x2, flyer x4
		slime x3, firefly x2, wanderer x1
		paraslime x1, slime x3, flyer x2, firefly x2
		wanderer x2, paraslime x2, firefly x3

7-4 hidden path, fake wall tiles
*/

scr_segmentInit();

global.rmNext = rm_lv2_boss;