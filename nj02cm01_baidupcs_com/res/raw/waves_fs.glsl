precision mediump float;

uniform float		globalTime;
uniform float		amplitude;
uniform vec2		resolution;
uniform float		frequencies[128];
uniform vec3		color;

int					ARRAY_SIZE = 128;
int					WAVES_INT = 8;
float				WAVES_FLOAT = 8.0;

vec3		calcWave(vec2 uv, float param, float it, float time)
{
	vec2	p;
	float	freq = param * 14.0;
	
	p.x = uv.x + it * 0.04 + freq * 0.03;
	p.y = uv.y + cos(p.x * 10.0 + time) * sin(p.x * 2.0) * freq * amplitude * ((it + 1.0) / WAVES_FLOAT);
	float intensity = abs(0.01 / p.y) * clamp(freq, 0.35, 2.0);
	return vec3(color.x * intensity, color.y * intensity * ((it + 1.0) / WAVES_FLOAT), color.z * intensity) * (3.0 / WAVES_FLOAT);
}

void main(void)
{
	vec2	uv = -1.0 + 2.0 * gl_FragCoord.xy / resolution.xy;
	float	time = globalTime * 2.0;
	vec3	color = vec3(0.0);
	int		index = 0;
	
	for (int it = 0; it < WAVES_INT; ++it)
	{
		color += calcWave(uv, frequencies[it * ARRAY_SIZE / WAVES_INT], 0.0, time);
	}

    
	gl_FragColor = vec4(color, 1.0);
}
