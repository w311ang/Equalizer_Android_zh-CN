precision mediump float;

uniform float		globalTime;
uniform float		amplitude;
uniform vec2		resolution;
uniform float		frequencies[128];
uniform vec3		color;

float dots = 16.0;
float radius = 0.25;
float brightness = 0.08;

vec3 hsv2rgb(vec3 c){
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main(void)
{
	vec2 p=(gl_FragCoord.xy-.5*resolution.xy)/min(resolution.x,resolution.y);
    vec3 c=vec3(0.0,0.0,0.0);

    for(float i=0.0;i<dots; i++){

        float vol = frequencies[int(128.0*i/dots)];
        float b = vol * brightness;

        float x = radius*cos(2.0*3.14*i/dots);
        float y = radius*sin(2.0*3.14*i/dots);
        vec2 o = vec2(x,y);

        vec3 dotCol = hsv2rgb(vec3((i + globalTime*10.0)/dots,1.0,1.0));

        c += b/(max(length(p-o),0.01))*dotCol;
    }

    gl_FragColor = vec4(c,1.0);
}
