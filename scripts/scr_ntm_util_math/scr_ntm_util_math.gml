///楕円判定
///@arg {Real} x x座標
///@arg {Real} y y座標
///@arg {Real} cx 楕円x座標
///@arg {Real} cy 楕円y座標
///@arg {Real} sx xscale
///@arg {Real} sy yscale
///@arg {Real} angle 楕円の角度
///@return {Bool}
///@pure
function point_in_ellipse(x, y, cx, cy, sx, sy, angle){
	var _delta = new Vector2(x - cx, y - cy);
	_delta.rot(-angle);
	var _val = (sqr(_delta.x) / sqr(sx) + sqr(_delta.y) / sqr(sy));
	return (_val <= 1);
}