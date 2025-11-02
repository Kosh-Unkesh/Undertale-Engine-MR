//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

const float PI = 3.141592653;

const int DISTORTION_TYPE_FULL = 0;

uniform int distortion_type;
uniform float distortion_amount;
uniform vec2 center;
uniform vec2 texture_size;

float direction(vec2 dest, vec2 src) {
	vec2 diff_vec = src - dest;
	return diff_vec.x == 0.0 ? sign(diff_vec.y) * PI / 2.0 : atan(diff_vec.y, diff_vec.x);
}

void main() {
	vec4 color = vec4(0.0);
	
	vec2 offset_vector = gl_FragCoord.xy - center;
	float offset_length = length(offset_vector);
	float result_length = offset_length;

	if (distortion_type == DISTORTION_TYPE_FULL)
	{
		// y = a * x ^ 2 + x
		// x = ( -1 + sqrt(1 + 4 * a * y) ) / (2 * a)
		if (abs(distortion_amount) < 0.00001)
		{
			result_length = offset_length;
		}
		else
		{
			result_length = (-1.0 + sqrt(1.0 + 4.0 * distortion_amount * offset_length)) / (2.0 * distortion_amount);
		}
	}
	
	vec2 distorted_uv = center + normalize(offset_vector) * result_length;
	distorted_uv /= texture_size;
	
	color = texture2D(gm_BaseTexture, distorted_uv);
	gl_FragColor = v_vColour * color;
}
