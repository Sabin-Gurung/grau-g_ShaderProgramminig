#version 330 core

layout (pixel_center_integer) in vec4 gl_FragCoord;
in vec4 frontColor;
out vec4 fragColor;

uniform int n = 3;

void main()
{
    if (mod(gl_FragCoord.y, n) != 0) discard;
    fragColor = frontColor;
}
