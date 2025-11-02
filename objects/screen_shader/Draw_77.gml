/// @description 全ての画面効果をかけたsurfaceの描画

if (not global.screen_shader_postdrew)
{
	prepare_screen_shader_surface()
	
	var surface_width = room_width, surface_height = room_height
	var screen_width, screen_height
	if (window_get_fullscreen())
	{
		screen_width = display_get_width()
		screen_height = display_get_height()
	}
	else
	{
		screen_width = window_get_width()
		screen_height = window_get_height()
	}
	var surface_x, surface_y, surface_scale
	if (surface_width / surface_height >= screen_width / screen_height)
	{
		surface_scale = screen_width / surface_width
		surface_x = 0
		surface_y = screen_height / 2 - surface_height / 2 * surface_scale
	}
	else
	{
		surface_scale = screen_height / surface_height
		surface_x = screen_width / 2 - surface_width / 2 * surface_scale
		surface_y = 0
	}
	
	draw_surface_ext(global.screen_shader_surface, surface_x, surface_y, surface_scale, surface_scale, 0, c_white, 1)
	
	surface_free(global.screen_shader_surface)
	global.screen_shader_postdrew = true
}