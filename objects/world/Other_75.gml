switch async_load["event_type"] {
	// ゲームパッドが新しく検出されたとき
	case "gamepad discovered":
	
	var _pad_index = async_load["pad_index"];
	
	gamepad_set_axis_deadzone(_pad_index, Input_GetGamepadAxisDeadzone());
	
	
	break;
	
	// ゲームパッドが切断されたとき
	case "gamepad lost":
	
	
	
	break;
}