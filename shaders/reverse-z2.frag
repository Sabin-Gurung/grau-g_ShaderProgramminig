#version 330 core


layout (pixel_center_integer) in vec4 gl_FragCoord;

in vec4 frontColor;
out vec4 fragColor;


void main()
{
    fragColor = frontColor;
		gl_FragDepth = 1.0 - gl_FragCoord.z;
}
