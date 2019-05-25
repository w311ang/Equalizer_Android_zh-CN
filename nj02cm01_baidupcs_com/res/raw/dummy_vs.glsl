attribute vec3	aPosition;

uniform mat4	mvpMatrix;

void main()
{
    gl_Position = mvpMatrix * vec4(aPosition, 1.0);
}