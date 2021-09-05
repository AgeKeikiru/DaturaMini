
if(altBlend){
    
    var _col = image_blend;
    image_blend = c_white;
    
    event_inherited();
    
    gpu_set_blendmode(bm_add);
    
    image_blend = _col;
    
    event_inherited();
    
    gpu_set_blendmode(bm_normal);

}else{
    event_inherited();
}