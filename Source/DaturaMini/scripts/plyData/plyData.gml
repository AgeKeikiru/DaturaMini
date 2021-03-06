function plyData(_src, _hp) constructor{
	
	src = _src;
	
	slot2 = false; //set true for 2nd party member to determine inputs
	
	uiCol = $FFFFFF;
	
	hp = _hp;
	hpMax = hp;
	hpRegen = hp;
	
	airOK = true; //used to make sure up/down attacks can only be used in air once
	
	podActive = false; //tear's force pod
	podMerged = false;
	
	s_idle = spr_imo_idle;
	s_move = spr_imo_move;

	state_atk = addAct(_src);
	
	state_atkUp = addAct(_src);
	state_atkUp.airLimit = true;
	state_atkUp.enCost = 1;
	
	state_atkDn = addAct(_src);
	state_atkDn.airLimit = true;
	state_atkDn.enCost = 1;
	
	state_def = addAct(_src);
	state_def.enCost = 1;

}