src = noone;
enCost = 0;
airLimit = false; //if air limited, disables midair actions after use
	
canRun = function(){ return true; /*abstract*/ }
		
run = function(){ /*abstract*/
	with src{ switchState(noone); }
}