//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

// シェーダーを作る際によく使われる関数をまとめたライブラリです。

const float PI = 3.141592653;

// 汎用

// 終

// 幾何関連
float direction(vec2 dest, vec2 src)
{
	vec2 gdiff = src - dest;
	
	return gdiff.x == 0.0 ? sign(gdiff.y)*PI/2.0 : atan(gdiff.y, gdiff.x);
}
// 終

// 乱数関連
float random(vec2 pos)
{
    return fract(sin(dot(pos.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

const int GENERAL_RANDOM_MAX_SEED = 32;
float general_random(float seeds[GENERAL_RANDOM_MAX_SEED], int seeds_length)
{
	int merge_tree_length = int(ceil(log2(float(seeds_length))));
	
	float current_merging_seeds[GENERAL_RANDOM_MAX_SEED];
	for (int i = 0; i < seeds_length; i ++)
	{
		current_merging_seeds[i] = seeds[i];
	}
	
	for (int i = 0; i < merge_tree_length; i ++)
	{
		int merge_pair_count = int(pow(2.0, float(merge_tree_length - i)) / 2.0);
		for (int j = 0; j < merge_pair_count; j ++)
		{
			current_merging_seeds[j] = random(vec2(current_merging_seeds[j * 2], current_merging_seeds[j * 2 + 1]));
		}
	}
	
	return current_merging_seeds[0];
}

float random_range(vec2 pos, float start, float end)
{
	return random(pos) * (end - start) + start;
}

float curve(float pos)
{
    return 1.0 - 3.0 * pow(pos, 2.0) + 2.0 * pow(abs(pos), 3.0);
}

float linear_func(float pos, float grad)
{
    return pos * grad;
}

float wavelet(ivec3 grid, vec3 pos)
{
    //int3 grid = float3(grid_src.x, fmod(grid_src.y, 36.0), grid_src.z);
    vec3 grad = vec3(
        random(vec2(random(vec2(grid.xy)), random(vec2(float(grid.z), 0.0)))) * 8.0 - 4.0,
        random(vec2(random(vec2(grid.xy)), random(vec2(float(grid.z), 1.0)))) * 8.0 - 4.0,
        random(vec2(random(vec2(grid.xy)), random(vec2(float(grid.z), 2.0)))) * 8.0 - 4.0
    );
    
    return curve(pos.x) * curve(pos.y) * curve(pos.z) * (linear_func(pos.x, grad.x) + linear_func(pos.y, grad.y) + linear_func(pos.z, grad.z));
}

float pnoise_3d(vec3 pos)
{
    vec3 pos_fract = fract(pos);
    ivec3 pos_floor = ivec3(floor(pos));
    
    float wavelet_000 = wavelet(pos_floor + ivec3(0, 0, 0), pos_fract - vec3(0.0, 0.0, 0.0));
    float wavelet_100 = wavelet(pos_floor + ivec3(1, 0, 0), pos_fract - vec3(1.0, 0.0, 0.0));
    float wavelet_010 = wavelet(pos_floor + ivec3(0, 1, 0), pos_fract - vec3(0.0, 1.0, 0.0));
    float wavelet_110 = wavelet(pos_floor + ivec3(1, 1, 0), pos_fract - vec3(1.0, 1.0, 0.0));
    float wavelet_001 = wavelet(pos_floor + ivec3(0, 0, 1), pos_fract - vec3(0.0, 0.0, 1.0));
    float wavelet_101 = wavelet(pos_floor + ivec3(1, 0, 1), pos_fract - vec3(1.0, 0.0, 1.0));
    float wavelet_011 = wavelet(pos_floor + ivec3(0, 1, 1), pos_fract - vec3(0.0, 1.0, 1.0));
    float wavelet_111 = wavelet(pos_floor + ivec3(1, 1, 1), pos_fract - vec3(1.0, 1.0, 1.0));

    float wavelet_x00 = mix(wavelet_000, wavelet_100, pos_fract.x);
    float wavelet_x10 = mix(wavelet_010, wavelet_110, pos_fract.x);
    float wavelet_x01 = mix(wavelet_001, wavelet_101, pos_fract.x);
    float wavelet_x11 = mix(wavelet_011, wavelet_111, pos_fract.x);
    
    float wavelet_xy0 = mix(wavelet_x00, wavelet_x10, pos_fract.y);
    float wavelet_xy1 = mix(wavelet_x01, wavelet_x11, pos_fract.y);

    float wavelet_xyz = mix(wavelet_xy0, wavelet_xy1, pos_fract.z);
    
    return wavelet_xyz;
}
// 終

// 描画関連
vec3 draw_rect_from_range(vec2 fragment_position, vec2 range_start, vec2 range_end)
{
	vec3 color = vec3(0.0);
	
	color = vec3(step(range_start.x, fragment_position.x) * (1.0 - step(range_end.x, fragment_position.x)) * step(range_start.y, fragment_position.y) * (1.0 - step(range_end.y, fragment_position.y)));
	
	return color;
}

vec3 draw_rect(vec2 fragment_position, vec2 rect_position, vec2 rect_size)
{
	vec3 color = vec3(0.0);
	
	color = draw_rect_from_range(fragment_position, rect_position - rect_size / 2.0, rect_position + rect_size / 2.0);
	
	return color;
}

vec4 mix_blend_color(vec4 src_color, vec4 dest_color)
{
	vec4 blended_color = vec4(0.0);
	
	blended_color.rgb = mix(src_color.rgb, dest_color.rgb, src_color.a);
	blended_color.a = mix(src_color.a, 1.0, dest_color.a);
	
	return blended_color;
}
// 終

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
}
