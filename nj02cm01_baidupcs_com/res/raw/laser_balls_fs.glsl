precision mediump float;

uniform float		globalTime;
uniform float		amplitude;
uniform vec2		resolution;
uniform float		frequencies[128];
uniform vec3		color;

void main(void)
{
	vec2 p = (gl_FragCoord.xy-.5*resolution.xy)/min(resolution.x,resolution.y);
    vec3 c = vec3(0.0);
    vec2 uv = gl_FragCoord.xy / resolution.xy;

    float wave = 0.7; /*frequencies[int(vec2(uv.x,0.75).x)];*/
    /*float coef = frequencies[int(vec2(uv.x,0.75).x)]*10.0 + 10.0; 8.0 */



    for(int i = 1; i<8; i++)
    {
        float flash = frequencies[int(128.0*float(i)/8.0)] * 0.02 + 0.032;
        float time = 2.*3.14*float(i)/8.0* (globalTime*0.7);
        float x = sin(time)*1.8*smoothstep( 0.0, 0.15, abs(wave - uv.y));
        float y = sin(0.5*time) *smoothstep( 0.0, 0.15, abs(wave - uv.y));
        y*=.5;
        vec2 o = .4*vec2(x*cos(globalTime*.5),y*sin(globalTime*.3));
        float red = fract(time);
        float green = 1.-red;
        c+= flash/(max(length(p-o),0.01))*vec3(red,green,sin(globalTime));
    }
    gl_FragColor = vec4(c,1.0);
}
