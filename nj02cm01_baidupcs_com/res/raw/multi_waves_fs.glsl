precision mediump float;

uniform float		globalTime;
uniform float		amplitude;
uniform vec2		resolution;
uniform float		frequencies[128];
uniform vec3		color;


void main(void)
{
	vec2 uPos = ( gl_FragCoord.xy / resolution.xy );

	uPos.y -= 0.5;

	vec3 color = vec3(0.0);
	float levels = 0.4;
	const float k = 5.;
	for( float i = 1.0; i < k; ++i )
	{
		float colorFrequencies = max(frequencies[int(67.0*i/k)] * 20.0,1.0);
		float t = globalTime * (1.0);

		uPos.y += exp(6.0*levels) * sin( uPos.x*i*i - t) * 0.01;
		float fTemp = abs(1.0/(50.0*k) / uPos.y);
		color += vec3(fTemp*(i*0.03), fTemp*i/k, colorFrequencies*pow(fTemp,0.93)*1.2 );
	}

	vec4 color_final = vec4(color, 65.0);
	gl_FragColor = color_final;
}
