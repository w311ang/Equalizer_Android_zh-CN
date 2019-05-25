precision mediump float;
 
uniform vec3 color;

uniform sampler2D	uTextureSampler;
varying vec3		vTexture;

void main()
{
	vec4	textureColor = texture2D(uTextureSampler, vTexture.xy);
	
    gl_FragColor = vec4(textureColor.x * color.r, textureColor.x * color.g, textureColor.x * color.b, 1.0);
}