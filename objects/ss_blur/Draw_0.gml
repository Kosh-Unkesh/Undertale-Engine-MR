/// @description 画面効果をかける

event_inherited()

start_shader_drawing()

if directional {
	shader_set(shd_directional_blur)
	
	var blur_uniform = {
		texel : shader_get_uniform(shd_directional_blur, "textureTexel"),
		radius : shader_get_uniform(shd_directional_blur, "radius"),
		bloom : shader_get_uniform(shd_directional_blur, "bloom"),
		angle : shader_get_uniform(shd_directional_blur, "angle")
	}
	
	var _texture = surface_get_texture(global.screen_shader_surface)
	var _texel = [texture_get_texel_width(_texture), texture_get_texel_height(_texture)]
	
	shader_set_uniform_f(blur_uniform.texel, _texel[0], _texel[1]);
	shader_set_uniform_f(blur_uniform.bloom, 1);
	shader_set_uniform_f(blur_uniform.radius, amount);
	shader_set_uniform_f(blur_uniform.angle, angle);
	
	draw_surface(global.screen_shader_surface, 0, 0)
	
	shader_reset()
} else if radial {
	shader_set(shd_radial_blur)
	
	var blur_uniform = {
		texel : shader_get_uniform(shd_radial_blur, "textureTexel"),
		radius : shader_get_uniform(shd_radial_blur, "radius"),
		bloom : shader_get_uniform(shd_radial_blur, "bloom"),
		center : shader_get_uniform(shd_radial_blur, "center"),
		factor : shader_get_uniform(shd_radial_blur, "factor")
	}
	
	var _texture = surface_get_texture(global.screen_shader_surface)
	var _texel = [texture_get_texel_width(_texture), texture_get_texel_height(_texture)]
	
	shader_set_uniform_f(blur_uniform.texel, _texel[0], _texel[1]);
	shader_set_uniform_f(blur_uniform.bloom, 1);
	shader_set_uniform_f(blur_uniform.radius, amount);
	shader_set_uniform_f(blur_uniform.center, room_width / 2, room_height / 2);
	shader_set_uniform_f(blur_uniform.factor, factor);
	
	draw_surface(global.screen_shader_surface, 0, 0)
	
	shader_reset()
} else {
	var _blurred_surface = surface_get_blur(global.screen_shader_surface, amount, amount, true)
	draw_surface(_blurred_surface, 0, 0)
	surface_free(_blurred_surface)
}

end_shader_drawing()