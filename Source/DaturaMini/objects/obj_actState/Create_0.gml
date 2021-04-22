src = noone;
enCost = 0;
airLimit = false; //if air limited, disables midair actions after use
endLag = 0;
lagCancel = 0.5; //multiplier, used for action cancel timing
	
canRun = function(){ return true; /*abstract*/ }
		
run = function(){ /*abstract*/
	with src{ switchState(noone); }
}