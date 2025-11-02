///インスタンスにY軸のsinウェーブアニメーションをマークする
///@arg {Id.Instance} id instanceID
///@arg {Real} power 揺れ幅
///@arg {Real} speed 揺れ速度
///@arg {String} tag 判別用タグ
///@arg {Bool} fixed 無効にするとY座標を自由に動かせますが、安定性は増します
function animwave_mark(_id, _power, _speed, _tag = "", _fixed = true){
	var _data = {
		id : _id,
		power : _power,
		speed : _speed,
		tag : _tag,
		y : _id.y,
		timer : 0,
		fixed : _fixed,
	}
	array_push(obj_ntm_animwave.wavelist, _data);
}

///sinウェーブアニメーションのマークが存在するかどうか
///@pure
///@arg {String} tag 判別用タグ
///@return {Bool}
function animwave_is_exists(_tag){
	return array_any(obj_ntm_animwave.wavelist, method({_tag}, function(_e) {
		return _e.tag == _tag;
	}));
}

///sinウェーブアニメーションのマークを削除する
///@arg {String} tag 判別用タグ
function animwave_remove(_tag){
	with (obj_ntm_animwave) {
		for (var i = 0; i < array_length(wavelist); i++) {
			var _data = wavelist[i];
			if (_data.tag == _tag) {
				array_delete(wavelist, i, 1);
				i--;
			}
		}
	}
}