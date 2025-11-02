alpha = 0.8 + dsin(current_time / 1000 * 180) * 0.1;

//var _press_space = keyboard_check(vk_space);
var _press_ctrl = keyboard_check(vk_control);
var _press_shift = keyboard_check(vk_shift);

var _pos = new Vector2(window_views_mouse_get_x(), window_views_mouse_get_y());
if (!_press_shift) {
	_pos.divide(5);
	_pos.x = round(_pos.x);
	_pos.y = round(_pos.y);
	_pos.mul(5);
}

x = _pos.x;
y = _pos.y;

if (_press_ctrl) {
	if (offset_mode) {
		if (mouse_wheel_up()) {
			offset.y -= _press_shift ? 1 : 5;
		}
		if (mouse_wheel_down()) {
			offset.y += _press_shift ? 1 : 5;
		}
	} else {
		if (mouse_wheel_up()) {
			angle += _press_shift ? 1 : 5;
		}
		if (mouse_wheel_down()) {
			angle -= _press_shift ? 1 : 5;
		}
	}
} else {
	if (offset_mode) {
		if (mouse_wheel_up()) {
			offset.x -= _press_shift ? 1 : 5;
		}
		if (mouse_wheel_down()) {
			offset.x += _press_shift ? 1 : 5;
		}
	} else {
		if (mouse_wheel_up()) {
			length += _press_shift ? 1 : 5;
		}
		if (mouse_wheel_down()) {
			length -= _press_shift ? 1 : 5;
		}
	}
}

if (_press_ctrl && keyboard_check_pressed(ord("C"))) {
	var _text = $"var _bone = MakeBone({x}, {y}, {length}, 0, 0, {angle});"
	if (offset.x != 0) _text += $"\n_bone.xoffset = {offset.x};"
	if (offset.y != 0) _text += $"\n_bone.yoffset = {offset.y};"
	clipboard_set_text(_text)
	audio_play_sound(snd_save, 0, 0);
}

if (mouse_check_button_pressed(mb_left)) {
	var _bone = MakeBone(x, y, length, 0, 0, angle);
	_bone.xoffset = offset.x;
	_bone.yoffset = offset.y;
}

if (mouse_check_button_pressed(mb_right)) {
	offset_mode = !offset_mode;
}