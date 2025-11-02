if (keyboard_check_pressed(vk_f1) && !instance_exists(obj_ntm_dev_bone)) {
	instance_create_depth(0, 0, 0, obj_ntm_dev_bone);
}