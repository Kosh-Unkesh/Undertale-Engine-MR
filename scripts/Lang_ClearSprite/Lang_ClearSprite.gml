function Lang_ClearSprite() {
	while(!ds_map_empty(global._gmu_lang_sprite)){
		var KEY=ds_map_find_last(global._gmu_lang_sprite);
		var VALUE=ds_map_find_value(global._gmu_lang_sprite,KEY);
		ds_map_delete(global._gmu_lang_sprite,KEY);
	}
	ds_map_clear(global._gmu_lang_sprite);
	return true;


}
