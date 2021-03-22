event_inherited();

#macro CC_HP_GREEN $75e397
#macro CC_EN_BLUE $c6ac4f
#macro CC_EN_RECHARGE $929292

var
_camX = camera_get_view_x(view_camera[0]),
_camY = camera_get_view_y(view_camera[0]),
_uiX = _camX + 20,
_uiY = _camY + 20,
_uiW = 6,
_c_uiFrame = $202020,
_colCurr = c_white,
_ply = currPly == plyTeam[1];

function drawUI(_spr, _col, _x, _y, _strokeCol){
	
	if(!is_undefined(_strokeCol)){
	
		draw_sprite_ext(_spr, 0, _x + 1, _y, 1, 1, 0, _strokeCol, draw_get_alpha());
		draw_sprite_ext(_spr, 0, _x + -1, _y, 1, 1, 0, _strokeCol, draw_get_alpha());
		draw_sprite_ext(_spr, 0, _x, _y + 1, 1, 1, 0, _strokeCol, draw_get_alpha());
		draw_sprite_ext(_spr, 0, _x, _y + -1, 1, 1, 0, _strokeCol, draw_get_alpha());
		
		draw_sprite_ext(_spr, 0, _x + -1, _y + -1, 1, 1, 0, _strokeCol, draw_get_alpha());
		draw_sprite_ext(_spr, 0, _x + -2, _y + -1, 1, 1, 0, _strokeCol, draw_get_alpha());
	
	}
	
	draw_sprite_ext(_spr, 0, _x, _y, 1, 1, 0, _col, draw_get_alpha());
	
}

//ui stroke
drawUI(spr_ui_labelFrame, c_black, _uiX, _uiY, currPly.uiCol);

for(var _i = 0; _i < 5; _i++){
	
	drawUI(spr_ui_hpFrame, c_black, _uiX + (_uiW * _i), _uiY, currPly.uiCol);
	
	drawUI(spr_ui_hpSubFrame, c_black, _uiX + (_uiW * _i), _uiY, currPly.uiCol);
	
	if(_i < enMax){
		drawUI(spr_ui_enFrame, c_black, _uiX + (_uiW * _i), _uiY, currPly.uiCol);
	}
	
}

//ui fill
drawUI(spr_ui_labelFrame, _c_uiFrame, _uiX, _uiY);
drawUI(spr_ui_labelTxt, c_white, _uiX, _uiY);

for(var _i = 0; _i < 5; _i++){
	
	//hp
	drawUI(spr_ui_hpFrame, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
	drawUI(spr_ui_hpFill, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
	
	if(_i < plyTeam[_ply].hpMax){
	
		_colCurr = c_dkgray;
		if(_i < plyTeam[_ply].hpRegen){ _colCurr = c_red; }
		if(_i < plyTeam[_ply].hp){ _colCurr = CC_HP_GREEN; }
	
		drawUI(spr_ui_hpFrame, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
		drawUI(spr_ui_hpFill, _colCurr, _uiX + (_uiW * _i), _uiY);
		drawUI(spr_ui_hpOver, c_white, _uiX + (_uiW * _i), _uiY);
	
	}
	
	//partner hp
	drawUI(spr_ui_hpSubFrame, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
	drawUI(spr_ui_hpSubFill, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
	
	if(_i < plyTeam[!_ply].hpMax){
	
		_colCurr = c_dkgray;
		if(_i < plyTeam[!_ply].hpRegen){ _colCurr = c_red; }
		if(_i < plyTeam[!_ply].hp){ _colCurr = CC_HP_GREEN; }
	
		drawUI(spr_ui_hpSubFrame, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
		
		drawUI(spr_ui_hpSubFill, (_i < plyTeam[!_ply].hpRegen) ? c_red : c_dkgray, _uiX + (_uiW * _i), _uiY);
		
		draw_sprite_part_ext(spr_ui_hpSubFill, 0, 0, 0, floor(sprite_get_width(spr_ui_hpSubFill) * clamp(plyTeam[!_ply].hp + -_i, 0, 1)), sprite_get_height(spr_ui_hpSubFill), _uiX + (_uiW * _i) + 5, _uiY + -11, 1, 1, (plyTeam[!_ply].hp + -_i < 1) ? CC_EN_RECHARGE : CC_HP_GREEN, 1);
	
	}
	
	//en
	if(_i < enMax){
	
		drawUI(spr_ui_enFrame, _c_uiFrame, _uiX + (_uiW * _i), _uiY);
		
		drawUI(spr_ui_enFill, c_dkgray, _uiX + (_uiW * _i), _uiY);
		
		draw_sprite_part_ext(spr_ui_enFill, 0, 0, 0, floor(sprite_get_width(spr_ui_enFill) * clamp(en + -_i, 0, 1)), sprite_get_height(spr_ui_enFill), _uiX + (_uiW * _i) + 1, _uiY, 1, 1, (en + -_i < 1) ? CC_EN_RECHARGE : CC_EN_BLUE, 1);
		
		drawUI(spr_ui_enOver, c_white, _uiX + (_uiW * _i), _uiY);
	
	}
	
}

if(checkDebugView()){

	//player = true; //idk why this is here

	draw_set_font(ft_small);
	draw_set_color(c_black);

	draw_text(_camX + 2, _camY + 2,
		"onGround: " + string(on_ground()) +
		"\nspd_x: " + string(spd_x) +
		"\nx: " + string(x) +
		"\ncam_x: " + string(cam_x)
	);

	draw_set_color(c_white);

}