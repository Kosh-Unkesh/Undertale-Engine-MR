for (var i = 0; i < array_length(wavelist); i++) {
	var _data = wavelist[i];
	var _inst = _data.id;
	if (instance_exists(_inst)) {
		if (_data.fixed) {
			_data.timer++;
			_inst.y = _data.y - dsin(_data.timer * _data.speed) * _data.power;
		} else {
			_inst.y = _data.y;
		}
	} else {
		array_delete(wavelist, i, 1);
		i--;
	}
}