for (var i = 0; i < array_length(wavelist); i++) {
	var _data = wavelist[i];
	if (!_data.fixed) {
		var _inst = _data.id;
		if (instance_exists(_inst)) {
			_data.y = _inst.y;
			_data.timer++;
			_inst.y -= dsin(_data.timer * _data.speed) * _data.power;
		}
	}
}