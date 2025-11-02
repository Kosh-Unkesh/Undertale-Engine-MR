start_shader_drawing()

var _shader = shd_radial_distortion
shader_set(_shader)

var param_distortion_type = shader_get_uniform(_shader, "distortion_type")
var param_distortion_amount = shader_get_uniform(_shader, "distortion_amount")
var param_center = shader_get_uniform(_shader, "center")
var param_texture_size = shader_get_uniform(_shader, "texture_size")
shader_set_uniform_i(param_distortion_type, 0)
shader_set_uniform_f(param_distortion_amount, amount)
shader_set_uniform_f(param_center, room_width / 2, room_height / 2)
shader_set_uniform_f(param_texture_size, room_width, room_height)

draw_surface(global.screen_shader_surface, 0, 0)

shader_reset()

end_shader_drawing()