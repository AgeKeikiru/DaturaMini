global.lst_tagged = ds_list_create();

function intf_tagging_implement(){
	
	arr_tags = [];
	
	ds_list_add(global.lst_tagged, id);
	
}

function hasTag(_o,_s){
	
	with(_o){
	
		for(var _i = 0; _i < array_length(arr_tags); _i++){
		
			if(arr_tags[_i] == _s){ return true; }
		
		}
	
		return false;
	
	}
	
}

function getTagged(_s){

	var _r = [];
	
	for(var _i = 0; _i < ds_list_size(global.lst_tagged); _i++){
	
		var _o = global.lst_tagged[| _i];
		
		if(instance_exists(_o) && hasTag(_o,_s)){
			array_push(_r, _o);
		}
	
	}
	
	return _r;

}