/// @description 初期化

if (not variable_global_exists("screen_shader_initialized"))
{
	global.screen_shader_surface = -1
	global.screen_shader_postdrew = false
	
	global.screen_shader_initialized = true
}

// screen_shaderを使用した際一部のオブジェクトが正常に描画されない場合は、depthの値を下げてください。
// screen_shaderを使用した際画面がborderより上に描画されてしまう場合は、borderのdepthの値を下げてください。
depth = -2000

_shader_surface = -1

function prepare_screen_shader_surface()
{
	if (!surface_exists(global.screen_shader_surface))
	{
		global.screen_shader_surface = surface_create(room_width, room_height)
		surface_copy(global.screen_shader_surface, 0, 0, application_surface)
	}
}

function start_shader_drawing()
{
	prepare_screen_shader_surface()
	
	_shader_surface = surface_create(room_width, room_height)
	surface_set_target(_shader_surface)
	draw_clear_alpha(c_black, 0)
}

function end_shader_drawing()
{
	surface_reset_target()
	
	surface_free(global.screen_shader_surface)
	global.screen_shader_surface = _shader_surface
}