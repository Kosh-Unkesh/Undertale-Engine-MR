var _pos = new Vector2(x, y);

//Draw BoneInfomation
draw_pixel(0, _pos.y, room_width, 1, 0, c_aqua);
draw_pixel(_pos.x, 0, 1, room_height, 0, c_orange);
draw_set_ca(c_white, 1);
draw_set_align(6);
draw_set_font(font_crypt_of_tomorrow);
var _info = "";

//Here Infomation
_info += $"pos: ({_pos.x}, {_pos.y})\n";

_info += $"offset: ({offset.x}, {offset.y})";
if (offset_mode) _info += " <EDIT>"
_info += "\n"

_info += $"length: {length}\n";
_info += $"angle: {angle}\n";

draw_text_transformed(_pos.x + 2, _pos.y - 2, _info, 2, 2, 0);
draw_set_align(0);


//Draw Bone
var _boneoffset = offset.copy().rot(angle);
_pos.add(_boneoffset);

draw_sprite_ext(spr_bone_body, 0, _pos.x, _pos.y, length, 1, angle, c_white, alpha);
//BoneHead Position -> _head
var _head = new Vector2(length, 0).rot(angle);
draw_sprite_ext(spr_bone_head, 0, _pos.x + _head.x, _pos.y + _head.y, 1, 1, angle, c_white, alpha);
draw_sprite_ext(spr_bone_head, 1, _pos.x - _head.x, _pos.y - _head.y, 1, 1, angle, c_white, alpha);
