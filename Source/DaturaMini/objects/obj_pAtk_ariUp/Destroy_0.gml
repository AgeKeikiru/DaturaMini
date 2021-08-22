event_inherited();
if(explosive){

    audf_playSfx(sfx_explode);
    
    with scr_place(obj_pAtk_breExpl, x, y){
        dmg = 0.5;
    }

}