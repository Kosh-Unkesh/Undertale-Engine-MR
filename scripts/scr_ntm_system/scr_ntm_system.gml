///IDEから実行されているかどうかを確認します
///@return {bool}
///@pure
function is_test()
{
	return (GM_build_type == "run");
}

///Builderの変数群から基盤のみ存在する変数をDataへ移行する
function send_builder_to_data(_builder)
{
	var _lists = variable_struct_get_names(self);
	
	array_foreach(_lists, method(_builder, function(_e){
		other[$_e] = self[$_e];
	}))
}
