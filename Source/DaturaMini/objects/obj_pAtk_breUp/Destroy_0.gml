event_inherited();

var _o = scr_place(obj_pAtk_breExpl, x, y);

_o.push = push;
_o.lift = lift;
_o.atkStun = atkStun;
_o.sp_freeze = sp_freeze;

if(largeExpl){
    
    _o.image_xscale = 4;
    _o.image_yscale = _o.image_xscale;
    
}

audf_playSfx(sfx_explode);